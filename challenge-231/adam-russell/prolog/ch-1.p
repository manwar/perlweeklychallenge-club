not_min_max(Numbers, NotMinMax):-
    min_list(Numbers, Minimum),
    max_list(Numbers, Maximum),
    delete(Numbers, Minimum, NumbersNoMinimum),
    delete(NumbersNoMinimum, Maximum, NumbersNoMinimumNoMaximum),
    ((length(NumbersNoMinimumNoMaximum, 0), NotMinMax = -1), !;
     (NotMinMax = NumbersNoMinimumNoMaximum)).