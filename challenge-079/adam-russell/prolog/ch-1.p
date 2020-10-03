set_bits(N, X):-
    set_bits(N, 0, X).
set_bits(0, X, X).    
set_bits(N, X_Acc, X):-    
    B is N /\ 1,
    X0 is X_Acc + B,
    N0 is N >> 1,
    set_bits(N0, X0, X).

count_bits(N, X) :-
    count_bits(N, 0, X).
count_bits(0, X, X).  
count_bits(N, X_Acc, X):-     
    set_bits(N, X0),
    X1 is X0 + X_Acc,
    N0 is N - 1,
    count_bits(N0, X1, X).

bit_count:-
    count_bits(4, X),
    X0 is X mod 1000000007,
    writef("%d \\% 1000000007 = %d\n", [X, X0]),
    count_bits(3, Y),
    Y0 is Y mod 1000000007,
    writef("%d \\% 1000000007 = %d\n", [Y, Y0]),
    halt.