prime_factors(N, L):- 
    N > 0,  
    prime_factors(N, L, 2).
prime_factors(1, [], _):- 
    !.
prime_factors(N, [F|L], F):-                     
    R is N // F, 
    N =:= R * F, 
    !, 
    prime_factors(R, L, F).
prime_factors(N, L, F):-
    next_factor(N, F, NF), 
    prime_factors(N, L, NF).
next_factor(_, 2, 3):- 
    !.
next_factor(N, F, NF):- 
    F * F < N, 
    !, 
    NF is F + 2.
next_factor(N, _, N).

powerful(N, X):-
    M is mod(N, X * X),
    M == 0.

imperfect(N):-
    Sqrt is round(sqrt(N)),
    S is Sqrt - 1,
    length(I, S),
    fd_domain(I, 2, Sqrt),
    fd_all_different(I),
    fd_labeling(I),!,
    maplist(imperfect(N), I).
imperfect(N, X):-
    D is log(N) / log(X),
    Check is abs(D - round(D)),
    \+ Check < 0.000001.

achilles(_) --> [].
achilles(Seen) --> [X], {current_prolog_flag(max_integer, MAX_INTEGER), 
                         between(2, MAX_INTEGER, X), \+ member(X, Seen), achilles(X)}, 
                   achilles([X|Seen]).

achilles(X):-
    prime_factors(X, Factors), 
    maplist(powerful(X), Factors),
    imperfect(X).

n_achilles(N, Achilles):-
    length(Achilles, N), 
    phrase(achilles([]), Achilles). 