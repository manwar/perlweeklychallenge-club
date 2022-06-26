primes(_) --> [].
primes(Seen) --> [X], {current_prolog_flag(max_integer, MAX_INTEGER), 
                         between(2, MAX_INTEGER, X),
                         fd_prime(X), 
                         \+ member(X, Seen)}, 
                      primes([X|Seen]).

product_list([], 1).
product_list([H|T], Product):-
    product_list(T, P),
    Product is H * P.

primorial(N, Primorial):-
    length(Primes, N),
    phrase(primes([]), Primes),
    product_list(Primes, Primorial), !.
    
primorials(_) --> [].
primorials(Seen) --> [Primorial],
                     {current_prolog_flag(max_integer, MAX_INTEGER), 
                         between(0, MAX_INTEGER, X),
                         primorial(X, Primorial), 
                         \+ member(X, Seen)},
                      primorials([X|Seen]).