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

brilliants(_) --> [].
brilliants(Seen) --> [X], {brilliant(X), \+ member(X, Seen)}, brilliants([X|Seen]).

brilliant(X):-
    current_prolog_flag(max_integer, MAX_INTEGER),
    between(1, MAX_INTEGER, X),
    prime_factors(X, Factors),
    length(Factors, 2),
    nth(1, Factors, First),
    nth(2, Factors, Second),
    number_chars(First, FirstChars),
    number_chars(Second, SecondChars),
    length(FirstChars, FirstCharsLength),
    length(SecondChars, SecondCharsLength),
    FirstCharsLength == SecondCharsLength.

n_brilliants(N, Brilliants):-
    length(Brilliants, N), 
    phrase(brilliants([]), Brilliants). 