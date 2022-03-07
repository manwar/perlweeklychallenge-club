padovan_primes(Size, Primes, PrimesAccum, A, B, C) --> {D is B + A, fd_not_prime(D)}, [A], padovan_primes(Size, Primes, PrimesAccum, B, C, D).
padovan_primes(Size, Primes, PrimesAccum, A, B, C) --> {D is B + A, fd_prime(D), append(PrimesAccum, [D], NewPrimesAccum), length(NewPrimesAccum, L), L < Size}, [A], padovan_primes(Size, Primes, NewPrimesAccum, B, C, D).
padovan_primes(Size, Primes, PrimesAccum, A, B, _) --> {D is B + A, fd_prime(D), append(PrimesAccum, [D], NewPrimesAccum), length(NewPrimesAccum, L), L >= Size, Primes = NewPrimesAccum}, [D].

n_padovan_primes(N, Primes):-
    succ(N, X),
    phrase(padovan_primes(X, PadovanPrimes, [], 1, 1, 1), _),
    [_|Primes] = PadovanPrimes.