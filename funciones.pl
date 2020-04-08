

% Cuenta cuantos elementos de la lista son iguales que R y se lo suma a C, que debe estar inicializado.
cuantosHay(R,[],C):-write("seras boba").
cuantosHay(R,[X|Y],C):- C1 is C, R = X,write("HOLA"), C is C1+1,cuantosHay(R,Y,C).
cuantosHay(R,[X,Y|Z],C):- C1 is C, R = Y,write("HOLA2"), C is C1+1, cuantosHay(R,Z,C).
cuantosHay(R,[X,Y,Z|W],C):- C1 is C, R = Z, C is C1+1,write("HOLA3"), cuantosHay(R,W,C).


dividirList(R,[R|B],[R|Y],D):-dividirList(R,B,Y,D),!.
dividirList(R,[X|B],Y,[X|D]):-dividirList(R,B,Y,D),!.
dividirList(R,[],Y,D).


count1(X,Y,1):- X=Y.
count1(X,Y,0):- not(X=Y).

countList(_,[],0):-!.
countList(X,[Y|L],C):-countList(X,L,C1),count1(X,Y,S), C is C1+S.

mixM(X,Y,X):- X =< Y.
mixM(X,Y,Y):- Y < X.