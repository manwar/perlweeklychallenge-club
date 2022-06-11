pernicious(_) --> [].
pernicious(Seen) --> [X], x(Seen, X), {set_bits(X, Bits), fd_prime(Bits)}, pernicious([X|Seen]).
x(Seen, X) --> {between(1, 100, X), \+ member(X, Seen)}. 

set_bits(N, X):-
    set_bits(N, 0, X).
set_bits(0, X, X).
set_bits(N, X_Acc, X):-
    B is N /\ 1,
    X0 is X_Acc + B,
    N0 is N >> 1,
    set_bits(N0, X0, X), !.