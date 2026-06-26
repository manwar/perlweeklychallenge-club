lecode_number(Str, Number) :-
        string_codes(Str, Codes),
        maplist([Before, After]>>(After is Before - 0'a), Codes, Digits),
        foldl([Digit, Before, After]>>(After is Before * 10 + Digit), Digits, 0, Number).

task(Str1, Str2, Str3, Output) :-
        maplist(lecode_number, [Str1, Str2, Str3], [Num1, Num2, Num3]),
        (Num1 + Num2 =:= Num3 ->
                Output = true
        ;
                Output = false
        ).
