primes_under_n(N, NumberPrimes):-
    findall(Prime, (between(2, N, I), fd_prime(I), Prime = I), Primes),
    length(Primes, NumberPrimes).  
