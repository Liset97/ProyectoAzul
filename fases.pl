:- [bd].

% Primero se escoge al jugador inicial ademas se llenan las facttorias

% Estos metodos son para escoger color, sacar de3 la bolsa y llenar las factorias.

cogeColor(R):- random(0,5,U), colores(U,R).

cogeBolsa(R):- cogeColor(R), bolsa(R,X1), X1 > 0, X is X1-1, retract(bolsa(R,X1)), assert(bolsa(R,X)).

llenaFact(X,R1,R2,R3,R4):- cogeBolsa(R1),cogeBolsa(R2),cogeBolsa(R3),cogeBolsa(R4), retract(factoria(X,none,none,none,none)), assert(factoria(X,R1,R2,R3,R4)).
llenaTodasFact(N):- N > 0, llenaFact(N,T1,T2,T3,T4), N1 is N-1, llenaTodasFact(N1). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     %
%   PRIMERA FASE: "OFERTA FACTORIA"   %
%                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%














