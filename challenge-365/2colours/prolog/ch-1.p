:- use_module(library(dcg/high_order)).
:- use_module(library(dcg/basics)).

digit_sum(Before, After) :- number_chars(Before, B_Chars), maplist([N, C]>>number_chars(N, [C]), B_Digits, B_Chars), sum_list(B_Digits, After).

lower_english(Pos) --> [LE], { between(0'a, 0'z, LE), Offset is 0'a - 1, plus(Pos, Offset, LE) }.

task1(Str, K, Output) :-
        string_codes(Str, Str_Codes),
        phrase(sequence(lower_english, Nums), Str_Codes),
        atomic_list_concat(Nums, Starting_Number_Atom),
        atom_number(Starting_Number_Atom, Starting_Number),
        foldall(digit_sum, between(1, K, _I), Starting_Number, Output).

% this is a bit overkill - regex would be sufficient, but regex is actually more annoying to integrate

alpha_part --> lower_english(_), sequence(lower_english, _).
punct --> `!` ; `.` ; `,`.
valid_token(1) --> alpha_part, optional((`-`, alpha_part), []), optional(punct, []).
fallback_token(0) --> nonblanks(_).
either_token(X) --> valid_token(X) ; fallback_token(X).

task2(Str, Output) :-
        string_codes(Str, Str_Codes),
        once(phrase(sequence(either_token, ` `, Validities), Str_Codes)),
        print_term(Validities, []),
        sum_list(Validities, Output).
