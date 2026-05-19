turning_distance(Previous_Letter, Current_Letter, D) :-
        maplist(char_code, [Previous_Letter, Current_Letter], [PL_Code, CL_Code]),
        Positive_Distance is abs(PL_Code - CL_Code),
        D is min(Positive_Distance, 26 - Positive_Distance).

task(Str, Output) :-
        string_chars(Str, Chars),
        foldl([Char, Sum_Before-Previous_Char, Sum_After-Char]>>(turning_distance(Previous_Char, Char, D), Sum_After is Sum_Before + D + 1), Chars, 0-a, Output-_).
