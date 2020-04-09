
% linea(X,Y) es las lineas que conforman el patron.
linea(CantL,Color).

% Definicion de Patron, donde:
% X = 1, Y = 2, Z = 3, V = 4, W = 5.... donde cada uno de ellos representan el numero de fichas en la linea correspondiente.
:- dynamic patron/6.
% patron(I,linea(X,C1),linea(Y,C2),linea(Z,C3),linea(V,C4),linea(W,C5)):- X =< 1, Y =< 2, Z =< 3, V =< 4, W =< 5.
patron(1,linea(0,none),linea(0,none),linea(0,none),linea(0,none),linea(0,none)).
patron(2,linea(0,none),linea(0,none),linea(0,none),linea(0,none),linea(0,none)).
patron(3,linea(0,none),linea(0,none),linea(0,none),linea(0,none),linea(0,none)).
patron(4,linea(0,none),linea(0,none),linea(0,none),linea(0,none),linea(0,none)).




% f(Q,W,E,R,T) representa las filas de la pared d0nde tiene una ficha x cada color como maximo.
:-dynamic f/5. 
% f(Negro,Azul,Amarillo,Rojo,Blanco):- Negro =< 1, Azul =< 1, Amarillo =< 1, Rojo =< 1, Blanco =< 1.
% Definicion de Pared:
:- dynamic pared/6.
% pared(I,f(X1,X2,X3,X4,X5),f(Y1,Y2,Y3,Y4,Y5),f(Z1,Z2,Z3,Z4,Z5),f(V1,V2,V3,V4,V5),f(W1,W2,W3,W4,W5)).
pared(1,f(0,0,0,0,0),f(0,0,0,0,0),f(0,0,0,0,0),f(0,0,0,0,0),f(0,0,0,0,0)).
pared(2,f(0,0,0,0,0),f(0,0,0,0,0),f(0,0,0,0,0),f(0,0,0,0,0),f(0,0,0,0,0)).
pared(3,f(0,0,0,0,0),f(0,0,0,0,0),f(0,0,0,0,0),f(0,0,0,0,0),f(0,0,0,0,0)).
pared(4,f(0,0,0,0,0),f(0,0,0,0,0),f(0,0,0,0,0),f(0,0,0,0,0),f(0,0,0,0,0)).

% Espacio de definicion de los jugadores donde:
% jugador(X,Puntuacion,Patron,Pared,Suelo).
% Primer parametro es el jugador
% Segundo parametro es la Puntuacion
% Tercer parametro, Patron, es una estructura que guarda la cantidad de fichas que hay en cada linea con el color correspondiente.
% Cuarto parametro la Pared,
% Quinto parametro es un numero que representa la cantidad de fichas en el suelo.
:- dynamic jugador/3.
jugador(1, 0, 0).
jugador(2, 0, 0).
jugador(3, 0, 0).
jugador(4, 0, 0).

% Espacio de definicion de las factorias.
% factoria(No,C1,C2,C3,C4).
% donde No representa el numero de la factoria, Ci los colores de las 4 fichas.
:- dynamic factoria/5.
factoria(1,none,none,none,none).
factoria(2,none,none,none,none).
factoria(3,none,none,none,none).
factoria(4,none,none,none,none).
factoria(5,none,none,none,none).
factoria(6,none,none,none,none).
factoria(7,none,none,none,none).
factoria(8,none,none,none,none).
factoria(9,none,none,none,none).

% Espacio de definicion del centro de Mesa.
:- dynamic cM/2.
cM(negro,0).
cM(azul,0).
cM(amarillo,0).
cM(rojo,0).
cM(blanco,0).

% Espacio de definicion Bolsa:
% bolsa(Negro,Azul,Amarillo,Rojo,Blanco,Total) inicialmente se cuenta con esta cantidad en la bolsa.
:- dynamic bolsa/2.
bolsa(negro,20).
bolsa(azul,20).
bolsa(amarillo,20).
bolsa(rojo,20).
bolsa(blanco,20).

% Espacio de definicion de los colores:
colores(1,negro).
colores(2,azul).
colores(3,amarillo).
colores(4,rojo).
colores(5,blanco).

% Espacio de definicion de la tapa:
:- dynamic tapa/2:
tapa(negro,0).
tapa(azul,0).
tapa(amarillo,0).
tapa(rojo,0).
tapa(blanco,0).


factoriasVacias(0):-!.
factoriasVacias(F):-factoria(F,X,Y,Z,W), X=none, Y=none, Z = none, W=none, N is F-1, factoriasVacias(N).


cMVacias():- cM(negro,X1),cM(azul,X2),cM(amarillo,X3),cM(rojo,X4),cM(blanco,X5), X1=0,X2=0,X3=0,X4=0,X5=0.


% Espacio para los cambios en patron y pared.
% N es el jugador, X el numero de fichas totales a en la ficha, 
actualizarP1(N,X,Y):- patron(N,linea(H,U),A,B,C,D),X1 is X+H,retract(patron(N,_,A,B,C,D)),assert(patron(N,linea(X1,Y),A,B,C,D)).
actualizarP2(N,X,Y):- patron(N,A,linea(H,U),B,C,D),X1 is X+H,retract(patron(N,A,_,B,C,D)),assert(patron(N,A,linea(X1,Y),B,C,D)).
actualizarP3(N,X,Y):- patron(N,A,B,linea(H,U),C,D),X1 is X+H,retract(patron(N,A,B,_,C,D)),assert(patron(N,A,B,linea(X1,Y),C,D)).
actualizarP4(N,X,Y):- patron(N,A,B,C,linea(H,U),D),X1 is X+H,retract(patron(N,A,B,C,_,D)),assert(patron(N,A,B,C,linea(X1,Y),D)).
actualizarP5(N,X,Y):- patron(N,A,B,C,D,linea(H,U)),X1 is X+H,retract(patron(N,A,B,C,D,_)),assert(patron(N,A,B,C,D,linea(X1,Y))).

reiniciarP1(N):-retract(patron(N,_,A,B,C,D)),assert(patron(N,linea(0,none),A,B,C,D)).
reiniciarP2(N):-retract(patron(N,A,_,B,C,D)),assert(patron(N,A,linea(0,none),B,C,D)).
reiniciarP3(N):-retract(patron(N,A,B,_,C,D)),assert(patron(N,A,B,linea(0,none),C,D)).
reiniciarP4(N):-retract(patron(N,A,B,C,_,D)),assert(patron(N,A,B,C,linea(0,none),D)).
reiniciarP5(N):-retract(patron(N,A,B,C,D,_)),assert(patron(N,A,B,C,D,linea(0,none))).

% Buscar en una fila 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   COMO DEBE QUEDAR LA MATRIZ EN PATRONES:   %
%                                             %
%           [1,2,3,4,5]                       %
%           [5,1,2,3,4]                       %
%           [4,5,1,2,3]                       %
%           [3,4,5,1,2]                       %
%           [2,3,4,5,1]                       %
%                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Verificacion por fila de  que puede estar:
% secX(J,CC).
sec1(J,1):- pared(J,f(X,Y1,Y2,Y3,Y4),A,B,C,D), X=0.
sec1(J,2):- pared(J,f(Y1,X,Y2,Y3,Y4),A,B,C,D), X=0.
sec1(J,3):- pared(J,f(Y1,Y2,X,Y3,Y4),A,B,C,D), X=0.
sec1(J,4):- pared(J,f(Y1,Y2,Y3,X,Y4),A,B,C,D), X=0.
sec1(J,5):- pared(J,f(Y1,Y2,Y3,Y4,X),A,B,C,D), X=0.

sec2(J,1):- pared(J,A,f(Y1,X,Y2,Y3,Y4),B,C,D), X=0.
sec2(J,2):- pared(J,A,f(Y1,Y2,X,Y3,Y4),B,C,D), X=0.
sec2(J,3):- pared(J,A,f(Y1,Y2,Y3,X,Y4),B,C,D), X=0.
sec2(J,4):- pared(J,A,f(Y1,Y2,Y3,Y4,X),B,C,D), X=0.
sec2(J,5):- pared(J,A,f(X,Y1,Y2,Y3,Y4),B,C,D), X=0.

sec3(J,1):- pared(J,A,B,f(Y1,Y2,X,Y3,Y4),C,D), X=0.
sec3(J,2):- pared(J,A,B,f(Y1,Y2,Y3,X,Y4),C,D), X=0.
sec3(J,3):- pared(J,A,B,f(Y1,Y2,Y3,Y4,X),C,D), X=0.
sec3(J,4):- pared(J,A,B,f(X,Y1,Y2,Y3,Y4),C,D), X=0.
sec3(J,5):- pared(J,A,B,f(Y1,X,Y2,Y3,Y4),C,D), X=0.

sec4(J,1):- pared(J,A,B,C,f(Y1,Y2,Y3,X,Y4),D), X=0.
sec4(J,2):- pared(J,A,B,C,f(Y1,Y2,Y3,Y4,X),D), X=0.
sec4(J,3):- pared(J,A,B,C,f(X,Y1,Y2,Y3,Y4),D), X=0.
sec4(J,4):- pared(J,A,B,C,f(Y1,X,Y2,Y3,Y4),D), X=0.
sec4(J,5):- pared(J,A,B,C,f(Y1,Y2,X,Y3,Y4),D), X=0.

sec5(J,1):- pared(J,A,B,C,D,f(Y1,Y2,Y3,Y4,X)), X=0.
sec5(J,2):- pared(J,A,B,C,D,f(X,Y1,Y2,Y3,Y4)), X=0.
sec5(J,3):- pared(J,A,B,C,D,f(Y1,X,Y2,Y3,Y4)), X=0.
sec5(J,4):- pared(J,A,B,C,D,f(Y1,Y2,X,Y3,Y4)), X=0.
sec5(J,5):- pared(J,A,B,C,D,f(Y1,Y2,Y3,X,Y4)), X=0.


cambSec1(J,1):-retract(pared(J,f(_,Y1,Y2,Y3,Y4),A,B,C,D)),assert(pared(J,f(1,Y1,Y2,Y3,Y4),A,B,C,D)).
cambSec1(J,2):-retract(pared(J,f(Y1,X,Y2,Y3,Y4),A,B,C,D)),assert(pared(J,f(Y1,2,Y2,Y3,Y4),A,B,C,D)).
cambSec1(J,3):-retract(pared(J,f(Y1,Y2,X,Y3,Y4),A,B,C,D)),assert(pared(J,f(Y1,Y2,3,Y3,Y4),A,B,C,D)).
cambSec1(J,4):-retract(pared(J,f(Y1,Y2,Y3,X,Y4),A,B,C,D)),assert(pared(J,f(Y1,Y2,Y3,4,Y4),A,B,C,D)).
cambSec1(J,5):-retract(pared(J,f(Y1,Y2,Y3,Y4,X),A,B,C,D)),assert(pared(J,f(Y1,Y2,Y3,Y4,5),A,B,C,D)).

cambSec2(J,1):-retract(pared(J,A,f(Y1,X,Y2,Y3,Y4),B,C,D)),assert(pared(J,A,f(Y1,1,Y2,Y3,Y4),B,C,D)).
cambSec2(J,2):-retract(pared(J,A,f(Y1,Y2,X,Y3,Y4),B,C,D)),assert(pared(J,A,f(Y1,Y2,2,Y3,Y4),B,C,D)).
cambSec2(J,3):-retract(pared(J,A,f(Y1,Y2,Y3,X,Y4),B,C,D)),assert(pared(J,A,f(Y1,Y2,Y3,3,Y4),B,C,D)).
cambSec2(J,4):-retract(pared(J,A,f(Y1,Y2,Y3,Y4,X),B,C,D)),assert(pared(J,A,f(Y1,Y2,Y3,Y4,4),B,C,D)).
cambSec2(J,5):-retract(pared(J,A,f(X,Y1,Y2,Y3,Y4),B,C,D)),assert(pared(J,A,f(5,Y1,Y2,Y3,Y4),B,C,D)).

cambSec3(J,1):-retract(pared(J,A,B,f(Y1,Y2,X,Y3,Y4),C,D)),assert(pared(J,A,B,f(Y1,Y2,1,Y3,Y4),C,D)).
cambSec3(J,2):-retract(pared(J,A,B,f(Y1,Y2,Y3,X,Y4),C,D)),assert(pared(J,A,B,f(Y1,Y2,Y3,2,Y4),C,D)).
cambSec3(J,3):-retract(pared(J,A,B,f(Y1,Y2,Y3,Y4,X),C,D)),assert(pared(J,A,B,f(Y1,Y2,Y3,Y4,3),C,D)).
cambSec3(J,4):-retract(pared(J,A,B,f(X,Y1,Y2,Y3,Y4),C,D)),assert(pared(J,A,B,f(4,Y1,Y2,Y3,Y4),C,D)).
cambSec3(J,5):-retract(pared(J,A,B,f(Y1,X,Y2,Y3,Y4),C,D)),assert(pared(J,A,B,f(Y1,5,Y2,Y3,Y4),C,D)).

cambSec4(J,1):-retract(pared(J,A,B,C,f(Y1,Y2,Y3,X,Y4),D)),assert(pared(J,A,B,C,f(Y1,Y2,Y3,1,Y4),D)).
cambSec4(J,2):-retract(pared(J,A,B,C,f(Y1,Y2,Y3,Y4,X),D)),assert(pared(J,A,B,C,f(Y1,Y2,Y3,Y4,2),D)).
cambSec4(J,3):-retract(pared(J,A,B,C,f(X,Y1,Y2,Y3,Y4),D)),assert(pared(J,A,B,C,f(3,Y1,Y2,Y3,Y4),D)).
cambSec4(J,4):-retract(pared(J,A,B,C,f(Y1,X,Y2,Y3,Y4),D)),assert(pared(J,A,B,C,f(Y1,4,Y2,Y3,Y4),D)).
cambSec4(J,5):-retract(pared(J,A,B,C,f(Y1,Y2,X,Y3,Y4),D)),assert(pared(J,A,B,C,f(Y1,Y2,5,Y3,Y4),D)).

cambSec5(J,1):-retract(pared(J,A,B,C,D,f(Y1,Y2,Y3,Y4,X))),assert(pared(J,A,B,C,D,f(Y1,Y2,Y3,Y4,1))).
cambSec5(J,2):-retract(pared(J,A,B,C,D,f(X,Y1,Y2,Y3,Y4))),assert(pared(J,A,B,C,D,f(2,Y1,Y2,Y3,Y4))).
cambSec5(J,3):-retract(pared(J,A,B,C,D,f(Y1,X,Y2,Y3,Y4))),assert(pared(J,A,B,C,D,f(Y1,3,Y2,Y3,Y4))).
cambSec5(J,4):-retract(pared(J,A,B,C,D,f(Y1,Y2,X,Y3,Y4))),assert(pared(J,A,B,C,D,f(Y1,Y2,4,Y3,Y4))).
cambSec5(J,5):-retract(pared(J,A,B,C,D,f(Y1,Y2,Y3,X,Y4))),assert(pared(J,A,B,C,D,f(Y1,Y2,Y3,5,Y4))).












