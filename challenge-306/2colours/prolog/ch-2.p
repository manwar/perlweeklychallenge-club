game([], 0).
game([Last_Remaining], Last_Remaining).
game(List, Result) :-
        length(List, N), N > 1,
        max_list(List, Max1),
        once(select(Max1, List, Rest)),
        max_list(Rest, Max2),
        once(nth0(Pos2, Rest, Max2, Rest2)),
        Diff is Max1 - Max2,
        (Diff =:= 0 ->
                game(Rest2, Result)
        ;
        true ->
                nth0(Pos2, New_List, Diff, Rest2),
                game(New_List, Result)
        ).

task2(Ints, Result) :- game(Ints, Result), !.
