concatenation_value([], 0).
concatenation_value([X], X).
concatenation_value([H|T], Sum):-
    last(T, Last),
    number_atom(H, L),
    number_atom(Last, R), 
    atom_concat(L, R, LR),
    number_atom(N, LR),
    append(Rest, [Last], T),
    concatenation_value(Rest, S),
    Sum is N + S.

main:-
    concatenation_value([6, 12, 25, 1], S0),
    write(S0), nl,
    concatenation_value([10, 7, 31, 5, 2, 2], S1),
    write(S1), nl,
    concatenation_value([1, 2, 10], S2),
    write(S2), nl.   
