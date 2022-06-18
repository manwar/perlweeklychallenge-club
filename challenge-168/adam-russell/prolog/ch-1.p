perrin_primes(A, B, C) --> {D is B + A, fd_not_prime(D)}, 
                           perrin_primes(B, C, D).
perrin_primes(A, B, C) --> {D is B + A, fd_prime(D), D \== C}, 
                           [D], perrin_primes(B, C, D).
perrin_primes(A, B, C) --> {D is B + A, fd_prime(D), D == C}, 
                           [], perrin_primes(B, C, D).                           
perrin_primes(_, _, _) --> [], !.

n_perrin_primes(N, PerrinPrimes):-
    length(PerrinPrimes, N), 
    phrase(perrin_primes(3, 0, 2), PerrinPrimes). 