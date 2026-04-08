task(Str, Output) :-
        string_chars(Str, Str_Chars),
        sort(0, @>=, Str_Chars, [First_Descending_Char|Rest_Descending_Chars]),
        append(Rest_Descending_Chars, [First_Descending_Char], Output_Chars),
        string_chars(Output, Output_Chars).
