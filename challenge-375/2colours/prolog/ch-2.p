task(Num, K, Output) :-
        number_chars(Num, Num_Chars),
        length(Sub, K),
        aggregate_all(count, (
                append([_, Sub, _], Num_Chars),
                number_chars(Sub_Num, Sub),
                Num mod Sub_Num =:= 0
                ), Output).
