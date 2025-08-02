:- initialization(main).

sum_char_diffs([], 0).
sum_char_diffs([_], 0).
sum_char_diffs([A, B|Xs], S) :-
    A > B,
    sum_char_diffs([B|Xs], S2), S is S2 + A - B.
sum_char_diffs([A, B|Xs], S) :-
    B >= A,
    sum_char_diffs([B|Xs], S2), S is S2 + B - A.

output_helper(Word) :-
    atom_codes(I0, Word), print(I0),
    write(' :: '),
    sum_char_diffs(Word, X0), write(X0), nl.

main:-
    maplist(output_helper, ["hello", "perl", "raku", "prolog"]),
    halt.
