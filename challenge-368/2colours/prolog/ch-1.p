task(Str, Char, Output) :-
        string_chars(Str, Str_Chars),
        aggregate_all(max(Num), (select(Char, Str_Chars, Remaining), number_chars(Num, Remaining)), Max),
        number_string(Max, Output).
