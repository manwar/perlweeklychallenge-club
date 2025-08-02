:- initialization(main).

str_to_chars(S, Cs) :- atom_codes(X, S), atom_chars(X, Cs).

defang_chars([], []).
defang_chars(['.'|Xs], ['[', '.', ']'|Y]) :- defang_chars(Xs, Y), !.
defang_chars([X|Xs], [X|Y]) :- defang_chars(Xs, Y).

defang_string(X, Y) :-
    str_to_chars(X, Cs),
    defang_chars(Cs, Dcs),
    atom_chars(Y, Dcs).

output_helper(String) :-
    atom_codes(I0, String), print(I0),
    write(' => '),
    defang_string(String, X0), write(X0), nl.

main:-
    maplist(output_helper, ["1.1.1.1", "255.101.1.0"]),
    halt.
