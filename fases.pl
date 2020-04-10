:- [bd,funciones].

% Primero se escoge al jugador inicial ademas se llenan las facttorias

% Estos metodos son para escoger color, sacar de3 la bolsa y llenar las factorias.

cogeColor(R):- random(1,6,U), colores(U,R).

cogeBolsa(R):- cogeColor(R), bolsa(R,X1), X1 > 0, X is X1-1, retract(bolsa(R,X1)), assert(bolsa(R,X)).

llenaFact(X,R1,R2,R3,R4):- cogeBolsa(R1),cogeBolsa(R2),cogeBolsa(R3),cogeBolsa(R4), retract(factoria(X,none,none,none,none)), assert(factoria(X,R1,R2,R3,R4)).
llenaTodasFact(N):- N > 0, llenaFact(N,T1,T2,T3,T4), N1 is N-1, llenaTodasFact(N1),!. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     %
%   PRIMERA FASE: "OFERTA FACTORIA"   %
%                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           Maneras de elegir los azulejos:

% Tomar de la Factoria:
buscaFact(R,F):- factoria(A,R,_,_,_), F is A, !.
buscaFact(R,F):- factoria(A,_,R,_,_), F is A, !.
buscaFact(R,F):- factoria(A,_,_,R,_), F is A, !.
buscaFact(R,F):- factoria(A,_,_,_,R), F is A, !.

% metodo para seleccionar un color de la factoria si es la opcion escogida
cogerFF(R,C,F):- cogeColor(R), buscaFact(R,F), factoria(F,X,Y,Z,W),countList(R,[X,Y,Z,W],C),!.
cogerFF(R,C,F):- cogerFF(R,C,F).

limpiar(F):- retract(factoria(F,_,_,_,_)), assert(factoria(F,none,none,none,none)).

% Para pasar las fichas restantes de una factoria al cantro de Mesa:
pasarCM(R,[]):- !.
pasarCM(R,[X|Y]):- R = X, pasarCM(R,Y).
pasarCM(R,[X|Y]):- not(R = X), meteCMesa(X,1),pasarCM(R,Y).

pasarFCM(R,F):- factoria(F,X,Y,Z,W), pasarCM(R,[X,Y,Z,W]),limpiar(F).

% Meter fichas para el centro de Mesa:
meteCMesa(R,C):-cM(R,A), C1 is C+A, retract(cM(R,A)),assert(cM(R,C1)).

sacarFF(R,F):-not(factoriasVacias(9)),cogerFF(R,C,F),pasarFCM(R,F).
% sacarFF(R,F):-cogerFC(R,C), F is 10.

% Tomar del Centro de la mesa
% metodo para seleccionar un color del centro de mesa
cogerFC(R,C):- cogeColor(R), cM(R,C1), C is C1, retract(cM(R,C1)), assert(cM(R,0)).

% Ponerle las fichas elegidas al jugador:
% ponerP(J,R,C) donde J es el indice del jugador, R es el codigo del color y C es la cantidad a ubicar.
ponerP(J,R,0):-!.
ponerP(J,R,C):-patron(J,linea(X,Y),A,B,V,D),X=0,sec1(J,R), actualizarP1(J,1,R), C1 is C-1, ponerP(J,R,C1).
ponerP(J,R,C):-patron(J,A,linea(X,Y),B,V,D),X<2,sec2(J,R), (Y=R; Y=none), P is 2-X, mixM(P,C,M), C1 is C-M, actualizarP2(J,M,R),ponerP(J,R,C1).
ponerP(J,R,C):-patron(J,A,B,linea(X,Y),V,D),X<3,sec3(J,R), (Y=R; Y=none), P is 3-X, mixM(P,C,M), C1 is C-M, actualizarP3(J,M,R),ponerP(J,R,C1).
ponerP(J,R,C):-patron(J,A,B,V,linea(X,Y),D),X<4,sec4(J,R), (Y=R; Y=none), P is 4-X, mixM(P,C,M), C1 is C-M, actualizarP4(J,M,R),ponerP(J,R,C1).
ponerP(J,R,C):-patron(J,A,B,V,D,linea(X,Y)),X<5,sec5(J,R), (Y=R; Y=none), P is 5-X, mixM(P,C,M), C1 is C-M, actualizarP5(J,M,R),ponerP(J,R,C1).
ponerP(J,R,C):-jugador(J,P,S),S1 is S+C,retract(jugador(J,P,S)),assert(jugador(J,P,S1)),meterTapa(R,C).


% Dado el jugador que metodo va a realizar:

ambas():-factoriasVacias(9),cMVacias().

juega(J):- not(factoriasVacias(9)),cogerFF(R,C,F),pasarFCM(R,F),colores(H,R),ponerP(J,H,C),!.
juega(J):- not(cMVacias()),cogerFC(R,C),colores(H,R),ponerP(J,H,C),cM(verde,X), X=0,retract(cM(verde,X)),assert(cM(verde,J)).
juega(J):-true.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                     %
%   SEGUNDA Y TERCERA FASE: "Alicatado de la Pared"   %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Esto se utiliza para meter en la tapa
meterTapa(R,C):-tapa(R,X), A is X+C, retract(tapa(R,X)),assert(tapa(R,A)).

% Este metodo se utiliza para meter de la tapa pa la bolsa.
meterTB([]):-!.
meterTB([X|Y]):- tapa(X,C),retract(bolsa(X,B)),assert(bolsa(X,U)),retract(tapa(X,T)),assert(tapa(X,0)),meterTB(Y).

% moverPP(J) es para mover la ficha correspondiente de cada patron para la pared 
moverPP(J,1):-patron(J,linea(X,Y),A,B,C,D), X=1,colores(U,Y),sec1(J,U),cambSec1(J,U),reiniciarP1(J).  % agregarle sumar puntos
moverPP(J,2):-patron(J,A,linea(X,Y),B,C,D), X=2,colores(U,Y),sec2(J,U),cambSec2(J,U),reiniciarP2(J),meterTapa(Y,1).
moverPP(J,3):-patron(J,A,B,linea(X,Y),C,D), X=3,colores(U,Y),sec3(J,U),cambSec3(J,U),reiniciarP3(J),meterTapa(Y,2).
moverPP(J,4):-patron(J,A,B,C,linea(X,Y),D),write(Y), X=4,write("Claro2"),colores(U,Y),sec4(J,Y),write("OJO2"),cambSec4(J,U),reiniciarP4(J),meterTapa(Y,3).
moverPP(J,5):-patron(J,A,B,C,D,linea(X,Y)),write(Y), X=5,write("Claro"),colores(U,Y),sec5(J,Y),write("OJO"),cambSec5(J,U),reiniciarP5(J),meterTapa(Y,4).

% para dado el jugador actual, cual es el siguiente segun las manecillas del reloj.
proximo(1,D):- D is 2.
proximo(2,D):- D is 3.
proximo(3,D):- D is 4.
proximo(4,D):- D is 1.

% Al terminar la fase anterior mover todas las fichas a la pared.
moverP(J,0):-!.
moverP(J,N):-moverPP(J,N),write("WTF"), N1 is N-1, moverP(J,N1).

% Recorre por los jugadores para actualizar la pared
jugadorAct(0):-!.
jugadorAct(J):-moverP(J,5),write("Movi"), K is J-1, jugadorAct(K).

% Aqui estaria la forma de llamar dado un jugador inicial a una ronda.
juegoC(J):-not(ambas()),juega(J),write("HEYYYY"),proximo(J,P),write("Cambie"),juegoC(P),!.

% Asi se llamaria a la primera ronda 
primeraRonda():-random(1,5,J),not(juegoC(J)),write("PIPO"),jugadorAct(4),write("SIIIIIIIIIIIIIIIIIIIIII").

% Con esto se verifica que una fila completa tenga fichas
checkFila(A,B,C,D,E):-not(A=0),not(B=0),not(C=0),not(D=0),not(E=0).

% Esta es la condicion de parada del juego, es decir que un jugador llene al menos una fila
jugadorTerm(J):- pared(J,f(X1,X2,X3,X4,X5),f(T1,T2,T3,T4,T5),f(Z1,Z2,Z3,Z4,Z5),f(V1,V2,V3,V4,V5),f(W1,W2,W3,W4,W5)),
                 checkFila(X1,X2,X3,X4,X5);checkFila(T1,T2,T3,T4,T5);checkFila(Z1,Z2,Z3,Z4,Z5);checkFila(V1,V2,V3,V4,V5);checkFila(W1,W2,W3,W4,W5).

% A partir de la segunda ronda, la comienza el jugador que esta marcado como jugador iniciar por la ficha verde en el centro de mesa
demasRonda():- bolsa(cM(verde,J)), retract(cM(verde,_)), assert(cM(verde,0)), juegoC(J),jugadorAct(4).

termina(0):- false.
termina(N):- not(jugadorTerm(N)),N1 is N-1,termina(0).

azul():-not(llenaTodasFact(9)),primeraRonda(),write("Hola"),not(termina(4)),azul1().

azul1():-not(llenaTodasFact(9)),demasRonda(),not(termina(4)),azul1().


