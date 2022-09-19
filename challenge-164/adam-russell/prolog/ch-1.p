:-initialization(main).

palindrome(X):-
    fd_labeling(X),
    number_codes(X, C),
    reverse(C, CR),
    number_codes(X, CR).

palindrome_primes(N, PalindromePrimes, NumberPrimes):-
    fd_labeling(NumberPrimes),
    length(Primes, NumberPrimes),
    fd_domain(Primes, 1, N),
    fd_all_different(Primes),
    maplist(palindrome, Primes),
    maplist(fd_prime, Primes),
    fd_labeling(Primes),
    PalindromePrimes = Primes.

palindrome_primes(N, Primes):- 
    NP is N // 2,
    fd_domain(NumberPrimes, 1, NP),
    fd_maximize(palindrome_primes(N, Primes, NumberPrimes), NumberPrimes).

palindrome_prime(N, Prime):-
    between(1, N, Prime),
    palindrome(Prime),
    fd_prime(Prime).

pp(_, _) --> [].
pp(N, Seen) --> [X], {palindrome_prime(N, X), \+ member(X, Seen)}, pp(N, [X|Seen]).

main:-
    findall(Prime, palindrome_prime(1000, Prime), PalindromePrimes),
    write(PalindromePrimes), nl.
