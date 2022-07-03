proper_divisors(X, Divisors):-
    Half is X // 2,
    findall(Divisor,(
        between(1, Half, Divisor),
        M is mod(X, Divisor),
        M == 0
    ), Divisors).

abundants_odd(_) --> [].
abundants_odd(Previous) --> [X], {abundant_odd(Previous, X)}, abundants_odd(X).

abundant_odd(Previous, X):-
    current_prolog_flag(max_integer, MAX_INTEGER),
    between(Previous, MAX_INTEGER, X),
    X > Previous,
    M is mod(X, 2),
    M == 1,
    proper_divisors(X, Divisors),
    sum_list(Divisors, DivisorsSum),
    DivisorsSum > X.

n_abundants(N, Abundants):-
    length(Abundants, N), 
    phrase(abundants_odd(-1), Abundants). 