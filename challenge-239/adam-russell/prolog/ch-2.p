consistent(Allowed, String, Consistent):-
    subtract(String, Allowed, Subtracted),
    length(Subtracted, SubtractedLength),
    ((SubtractedLength == 0, Consistent = 1);
     (SubtractedLength == 1, Consistent = 0)).

consistent_strings(Strings, Allowed, ConsistentStringsCount):-
    maplist(consistent(Allowed), Strings, ConsistentStrings),
    sum_list(ConsistentStrings, ConsistentStringsCount).