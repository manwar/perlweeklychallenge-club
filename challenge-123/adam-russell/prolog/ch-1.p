:-initialization(main).  

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

ugly(N, UglyNumber):-
    ugly(N, 1, 1, _, UglyNumber).  
ugly(1, _, _, _, 1).
ugly(N, _, N, UglyNumber, UglyNumber).
ugly(N, X, I, _, UglyNumber):-  
    prime_factors(X, Factors), 
    member(Factor, Factors),   
    (Factor == 2; Factor == 3; Factor == 5), 
    X0 is X + 1,  
    I0 is I + 1,
    ugly(N, X0, I0, X, UglyNumber).  
ugly(N, X, I, UglyNext, UglyNumber):-  
    X0 is X + 1,  
    ugly(N, X0, I, UglyNext, UglyNumber).  

main:-
    ugly(10, UglyNumber),
    write(UglyNumber), nl,
    halt.   
