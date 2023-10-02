difference(X, Y, Z):-
    Z is abs(X - Y).

differences(_, 0, LeftAccum, RightAccum, LeftRightDifferences):-
    maplist(difference, LeftAccum, RightAccum, LeftRightDifferences).
differences(Numbers, Index, LeftAccum, RightAccum, LeftRightDifferences):-
    length(Numbers, L),
    Left is Index - 1,
    Right is L - Index,
    length(Prefix, Left),
    length(Suffix, Right),
    prefix(Prefix, Numbers),
    suffix(Suffix, Numbers),
    sum_list(Prefix, LeftSum),
    sum_list(Suffix, RightSum),
    succ(IndexNext, Index),
    differences(Numbers, IndexNext, [LeftSum|LeftAccum], [RightSum|RightAccum], LeftRightDifferences).

left_right_differences(Numbers, LeftRightDifferences):-
    length(Numbers, L),
    differences(Numbers, L, [], [], LeftRightDifferences).
    
    