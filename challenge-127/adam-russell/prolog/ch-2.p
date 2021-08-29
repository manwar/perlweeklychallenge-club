:-initialization(main).

conflicts(Intervals, Conflicts):-
    conflicts(Intervals, Conflicts, []).  
conflicts([_|[]], Conflicts, ConflictsAccum):-
    sort(ConflictsAccum, Conflicts).  
conflicts([H|T], Conflicts, ConflictsAccum):-
    last(T, Last),  
    append(Intervals, [Last], T),   
    append([H], Intervals, CompareIntervals),  
    comparisons(Last, CompareIntervals, HasConflicts),
    append(ConflictsAccum, HasConflicts, ConflictsAccumUpdated),  
    conflicts(CompareIntervals, Conflicts, ConflictsAccumUpdated).      

comparisons(Interval, CompareIntervals, Conflicts):-
    comparisons(Interval, CompareIntervals, Conflicts, []). 
comparisons(_, [], Conflicts, Conflicts). 
comparisons(Interval, [[H0|T0]|T], Conflicts, ConflictsAccum):-
    [I|J] = Interval,  
    I >= H0,
    I =< T0,
    comparisons([I|J], T, Conflicts, [Interval|ConflictsAccum]). 
comparisons([I|J], [_|T], Conflicts, ConflictsAccum):-
    comparisons([I|J], T, Conflicts, ConflictsAccum). 

main:-
    conflicts([[1, 4], [3, 5], [6, 8], [12, 13], [3, 20]], Conflicts0),
    write(Conflicts0), nl,   
    conflicts([[3, 4], [5, 7], [6, 9], [10, 12], [13, 15]], Conflicts1),
    write(Conflicts1), nl,   
    halt.  
