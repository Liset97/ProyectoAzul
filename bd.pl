
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
f(Negro,Azul,Amarillo,Rojo,Blanco):- Negro =< 1, Azul =< 1, Amarillo =< 1, Rojo =< 1, Blanco =< 1.
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
colores(,negro).
colores(2,azul).
colores(3,amarillo).
colores(4,rojo).
colores(5,blanco).





