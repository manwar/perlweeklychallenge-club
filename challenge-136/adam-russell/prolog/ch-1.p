:-initialization(main).

two_friendly(M, N):-
    current_prolog_flag(max_integer, MAX_INTEGER),
    between(1, MAX_INTEGER, M),
    between(1, MAX_INTEGER, N),
    GCD is gcd(M, N), 
    P is log(2, GCD), 
    P0 is ceiling(P), 
    P1 is floor(P), 
    P0 == P1. 

main:-
    (two_friendly(8, 24), format("1~n", _); format("0~n", _)),
    (two_friendly(26, 39), format("1~n", _); format("0~n", _)),
    (two_friendly(4, 10), format("1~n", _); format("0~n", _)),
    halt.
    