next_candidate(2, 3) :- !.
next_candidate(N, N2) :- N2 is N + 2.

prime_factors(1, _) --> !, [].
prime_factors(Number, Current_Candidate) --> { Current_Candidate ** 2 > Number }, !, [Number].
prime_factors(Number, Current_Candidate) --> { divmod(Number, Current_Candidate, Div, 0) }, !, [Current_Candidate], prime_factors(Div, Current_Candidate).
prime_factors(Number, Current_Candidate) --> { next_candidate(Current_Candidate, Next_Candidate) }, prime_factors(Number, Next_Candidate).

prime_factors(Number, Factors) :- phrase(prime_factors(Number, 2), Factors).

omega(0, Factors, Omega) :- clumped(Factors, Factors_RLE), length(Factors_RLE, Omega).
omega(1, Factors, Omega) :- length(Factors, Omega).


task(Number, Mode, Output) :-
        prime_factors(Number, Factors),
        omega(Mode, Factors, Output).
