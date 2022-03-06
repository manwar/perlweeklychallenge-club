:-initialization(main).
/*
 * You are given possible permutations of the string 'PERL'.
 * Write a script to find any permutations missing from the list.
*/
make_lists([], []).
make_lists([Word|Words], [List|Rest]):-
    atom_chars(Word, List),
    make_lists(Words, Rest).

missing_permutation(Word, Permutations, Missing):-
    atom_chars(Word, Chars),
    permutation(Chars, Permutation),
    \+ member(Permutation, Permutations),
    atom_chars(Missing, Permutation).

main:-
    make_lists(['PELR', 'PREL', 'PERL', 'PRLE', 'PLER', 'PLRE', 'EPRL', 'EPLR', 'ERPL',
                'ERLP', 'ELPR', 'ELRP', 'RPEL', 'RPLE', 'REPL', 'RELP', 'RLPE', 'RLEP',
                'LPER', 'LPRE', 'LEPR', 'LRPE', 'LREP'], Permutations),
    missing_permutation('PERL', Permutations, Missing),
    write(Missing), nl,
    halt.