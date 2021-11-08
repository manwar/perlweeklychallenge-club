:-initialization(main).  

set_bits(N, X):-
    set_bits(N, 0, X).
set_bits(0, X, X).    
set_bits(N, X_Acc, X):-    
    B is N /\ 1,
    X0 is X_Acc + B,
    N0 is N >> 1,
    set_bits(N0, X0, X), !.

next_same_bits(N, NextSameBits):-
    current_prolog_flag(max_integer, MAX_INTEGER),
    set_bits(N, NumberBits),
    N0 is N + 1, 
    between(N0, MAX_INTEGER, X),
    set_bits(X, B), 
    B == NumberBits,
    NextSameBits = X.

main:-
    next_same_bits(3, NextSameBits0),
    write(NextSameBits0), nl,
    next_same_bits(12, NextSameBits1),
    write(NextSameBits1), nl,
    halt.
