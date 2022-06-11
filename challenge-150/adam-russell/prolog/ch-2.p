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

square_free(N, SquareFree):-
    findall(X,
        (between(1, N, X),
         prime_factors(X, PrimeFactors),
         sort(PrimeFactors, PrimeFactorsSorted),
         msort(PrimeFactors, PrimeFactorsMSorted),
         length(PrimeFactorsSorted, SortedLength),
         length(PrimeFactorsMSorted, MSortedLength),
         SortedLength == MSortedLength), SquareFree).
    