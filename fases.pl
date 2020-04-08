:- [bd,funciones].

% Primero se escoge al jugador inicial ademas se llenan las facttorias

% Estos metodos son para escoger color, sacar de3 la bolsa y llenar las factorias.

cogeColor(R):- random(1,6,U), colores(U,R).

cogeBolsa(R):- cogeColor(R), bolsa(R,X1), X1 > 0, X is X1-1, retract(bolsa(R,X1)), assert(bolsa(R,X)).

llenaFact(X,R1,R2,R3,R4):- cogeBolsa(R1),cogeBolsa(R2),cogeBolsa(R3),cogeBolsa(R4), retract(factoria(X,none,none,none,none)), assert(factoria(X,R1,R2,R3,R4)).
llenaTodasFact(N):- N > 0, llenaFact(N,T1,T2,T3,T4), N1 is N-1, llenaTodasFact(N1). 

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
cogerFF(R,C,F):- cogeColor(R), buscaFact(R,F), factoria(F,X,Y,Z,W),countList(R,[X,Y,Z,W],A),C is A.
limpiar(F):- retract(factoria(F,_,_,_,_)), assert(factoria(F,none,none,none,none)).

% Para pasar las fichas restantes de una factoria al cantro de Mesa:
pasarCM(R,[]):- true.
pasarCM(R,[X|Y]):- R = X, pasarCM(R,Y).
pasarCM(R,[X|Y]):- not(R = X), meteCMesa(X,1),pasarCM(R,Y).

pasarFCM(R,F):- factoria(F,X,Y,Z,W), pasarCM(R,[X,Y,Z,W]),limpiar(F).

% Meter fichas para el centro de Mesa:
meteCMesa(R,C):-cM(R,A), C1 is C+A, retract(cM(R,A)),assert(cM(R,C1)).


% Tomar del Centro de la mesa
% metodo para seleccionar un color del centro de mesa
cogerFC(R,C):- cogeColor(R), cM(R,C1), C is C1, retract(cM(R,C1)), assert(cM(R,0)).

% Ponerle las fichas elegidas al jugador:
% ponerP(J,R,C) donde J es el indice del jugador, R es el codigo del color y C es la cantidad a ubicar.
ponerP(J,R,0):-true.
ponerP(J,R,C):-patron(J,linea(X,Y),A,B,V,D),X=0,sec1(J,R), actualizarP1(J,1,R), C1 is C-1, ponerP(J,R,C1).
ponerP(J,R,C):-patron(J,A,linea(X,Y),B,V,D),X<2,sec2(J,R), (Y=R; Y=none), P is 2-X, mixM(P,C,M), C1 is C-M, actualizarP2(J,M,R),ponerP(J,R,C1).
ponerP(J,R,C):-patron(J,A,B,linea(X,Y),V,D),X<3,sec3(J,R), (Y=R; Y=none), P is 3-X, mixM(P,C,M), C1 is C-M, actualizarP3(J,M,R),ponerP(J,R,C1).
ponerP(J,R,C):-patron(J,A,B,V,linea(X,Y),D),X<4,sec4(J,R), (Y=R; Y=none), P is 4-X, mixM(P,C,M), C1 is C-M, actualizarP4(J,M,R),ponerP(J,R,C1).
ponerP(J,R,C):-patron(J,A,B,V,D,linea(X,Y)),X<5,sec5(J,R), (Y=R; Y=none), P is 5-X, mixM(P,C,M), C1 is C-M, actualizarP5(J,M,R),ponerP(J,R,C1).
ponerP(J,R,C):-jugador(J,P,S),S1 is S+C,retract(jugador(J,P,S)),assert(jugador(J,P,S1)).








