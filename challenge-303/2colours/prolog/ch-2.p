:- use_module(library(dcg/high_order)).

ascension([Value1-Count1, Value2-Count2 | Rest]) --> [Value1-Count1], { plus(Value1, 1, Value2) }, ascension([Value2-Count2|Rest]).
ascension([Head]) --> [Head].

max_score([], 0).
max_score([Value], Value).
max_score([V1, V2], Score) :- Score is max(V1, V2).
max_score(Values, Score) :-
        length(Values, Orig_Length),
        Orig_Length >= 3,
        Half_Without_Lower_Length is Orig_Length div 2 - 1,
        Half_Length is Orig_Length div 2,
        length(First_Part_Without_Lower, Half_Without_Lower_Length),
        append(First_Part_Without_Lower, [_Lower, Pivot, Upper|Second_Part_Without_Upper], Values),
        length(First_Part, Half_Length),
        append(First_Part, _Rest, Values),
        max_score(First_Part_Without_Lower, FPS),
        max_score(Second_Part_Without_Upper, SPS),
        Score_With_Pivot is FPS + SPS + Pivot,
        max_score(First_Part, FPLS),
        max_score([Upper|Second_Part_Without_Upper], USPS),
        Score_Without_Pivot is FPLS + USPS,
        Score is max(Score_With_Pivot, Score_Without_Pivot).
        
task2(Ints, Max_Score) :-
        msort(Ints, Ints_Sorted),
        clumped(Ints_Sorted, Ints_Grouped),
        once(phrase(sequence(ascension, Ascensions), Ints_Grouped)),
        maplist([Group, Max_Group_Score]>>(
                maplist([Value-Count, Worth]>>(Worth is Value * Count), Group, Worths),
                max_score(Worths, Max_Group_Score)
                ), Ascensions, Max_Scores),
        sum_list(Max_Scores, Max_Score).
