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

factor_concat(Factors, Atom):-
    factor_concat(Factors, '', Atom).
factor_concat([], Atom, Atom).
factor_concat([H|T], AtomAccum, Atom):-
    number_atom(H, A),
    atom_concat(AtomAccum, A, UpdatedAtomAccum),
    factor_concat(T, UpdatedAtomAccum, Atom).

home_prime(N, HomePrime):-
    prime_factors(N, Factors),
    factor_concat(Factors, A),
    number_atom(Number, A),
    fd_not_prime(Number),
    home_prime(Number, HomePrime).    
home_prime(N, HomePrime):-
    prime_factors(N, Factors),
    factor_concat(Factors, A),
    number_atom(Number, A),
    fd_prime(Number),
    HomePrime = Number. 