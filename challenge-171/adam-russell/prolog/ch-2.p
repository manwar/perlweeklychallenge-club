f(S, T):-
    T is S + S.
    
g(S, T):-
    T is S * S.
    
compose(F, G, H):-
    asserta((h(X, Y) :- call(G, X, X0), call(F, X0, Y))),
    H = h.