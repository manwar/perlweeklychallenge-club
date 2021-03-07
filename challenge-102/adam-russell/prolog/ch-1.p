:-initialization(main).

perfect_square(N):-
    A is floor(sqrt(N)), 
    N is A * A.

rare(N, N, Rares, Rares). 
rare(Lower, Upper, RareAccum, Rares):-
    number_codes(Lower, C),
    reverse(C, CR), 
    number_codes(R1, CR),
    X0 is Lower + R1,
    X1 is Lower - R1,
    perfect_square(X0),
    perfect_square(X1),
    Next is Lower + 1,
    rare(Next, Upper, [Lower|RareAccum], Rares).
rare(Lower, Upper, RareAccum, Rares):-
    Next is Lower + 1,
    rare(Next, Upper, RareAccum, Rares).

rare_numbers(N, Rares):-
    Lower is 10 ^ (N - 1),   
    Upper is (10 ^ N) - 1,
    rare(Lower, Upper, [], Rares). 

main:-
    rare_numbers(2, Rares2),
    write(Rares2), nl, 
    rare_numbers(6, Rares6),
    write(Rares6), nl, 
    rare_numbers(9, Rares9),
    write(Rares9), nl,
    halt.
