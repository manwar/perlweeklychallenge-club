:- use_module(library(dcg/high_order)).

task1(Int, Result) :-
        number_chars(Int, Int_Chars),
        length(Int_Chars, Int_Length),
        Prefix_Length is (Int_Length - 1) mod 3 + 1,
        Group_Count is (Int_Length - 1) div 3,
        length(Prefix, Prefix_Length),
        length(Groups, Group_Count),
        maplist([Group]>>length(Group, 3), Groups),
        append([Prefix|Groups], Int_Chars),
        foldl([Current_Group, Chars_Before, Chars_After]>>append([Chars_Before, [','], Current_Group], Chars_After), Groups, Prefix, Result_Chars),
        string_chars(Result, Result_Chars).

