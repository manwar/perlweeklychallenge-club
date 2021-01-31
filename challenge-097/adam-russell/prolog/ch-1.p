:-initialization(main).

caesar([], [], _).
caesar([H|T], [C|Cypher], N):-
    C is H - N,
    C >= 65,
    caesar(T, Cypher, N).
caesar([H|T], [C|Cypher], N):-
    C0 is H - N,
    C0 < 65,
    C is C0 + 26,
    caesar(T, Cypher, N).

main:-
    caesar("ABCDEFGHIJKLMNOPQRSTUVWXYZ", C, 3),
    atom_codes(CypherText, C),
    write(CypherText), nl,
    halt.