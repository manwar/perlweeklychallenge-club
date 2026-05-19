concatenate_string_list(Str_List, Str) :-
        foldl([Current_Str, Before, After]>>string_concat(Before, Current_Str, After),
                Str_List,
                "",
                Str).

task(Arr1, Arr2, Output) :-
        maplist(concatenate_string_list, [Arr1, Arr2], [Str1, Str2]),
        (Str1 = Str2 ->
                Output = true
        ;
                Output = false
        ).
