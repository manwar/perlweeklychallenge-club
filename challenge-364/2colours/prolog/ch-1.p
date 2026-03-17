:- use_module(library(dcg/basics)).
:- use_module(library(dcg/high_order)).

small_char(Char) --> digit(D), { D \= 0'0, number_codes(Num, [D]), own_char(Num, Char) }.

large_char(Char) --> valid_2digit(Codes), `#`, { number_codes(Num, Codes), own_char(Num, Char) }.

valid_2digit([0'1, D]) --> `1`, digit(D).
valid_2digit([0'2, D]) --> `2`, digit(D), { between(0'0, 0'6, D) }.

own_char(Char) --> large_char(Char) ; small_char(Char).

own_char(Own_Code, Char) :- True_Code is Own_Code + 0'a - 1, char_code(Char, True_Code).

task1(Str, Output) :-
        string_codes(Str, Str_Codes),
        once(phrase(sequence(own_char, Output_Chars), Str_Codes)),
        string_chars(Output, Output_Chars).

funny(g) --> `G`.
funny(o) --> `()`.
funny(al) --> `(al)`.

textual(g) --> `G`.
textual(o) --> `o`.
textual(al) --> `al`.

task2(Str, Output) :-
        string_codes(Str, Str_Codes),
        phrase(sequence(funny, Parsed), Str_Codes),
        phrase(sequence(textual, Parsed), Output_Codes),
        string_codes(Output, Output_Codes).
