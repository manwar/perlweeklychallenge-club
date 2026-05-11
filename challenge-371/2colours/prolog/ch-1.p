:- use_module(library(clpfd)).

to_pos(Lc_Letter, Lc_Pos) :-  Lc_Pos #= Lc_Code - 0'a + 1, between(1, 26, Lc_Pos), char_code(Lc_Letter, Lc_Code).
to_pos(?, _Unknown).

task(Seq, Output) :-
        maplist(to_pos, Seq, [First, Second, Third|Rest]),
        D1 #= Second - First,
        D2 #= Third - Second,
        foldl([Current, Current_Before-Difference_Before, Current-Difference_After]>>(
                Current_Before + Difference_Before #= Current,
                once(select(Difference_Before, [D1, D2], [Difference_After]))
                ), Rest, Third-D1, _),
        once(maplist(to_pos, Seq_Solved, [First, Second, Third|Rest])),
        select(?, Seq, Output, Seq_Solved).
