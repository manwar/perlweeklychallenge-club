subtract_minimum(Minimum, X, Y):-
    Y is X - Minimum.

zero_array(Numbers, Operations):-
    delete(Numbers, 0, NumbersNoZero),
    zero_array(NumbersNoZero, 0, Operations).
zero_array([], Operations, Operations).    
zero_array(Numbers, OperationsCounter, Operations):-
    delete(Numbers, 0, NumbersNoZero),
    min_list(NumbersNoZero, Minimum),
    maplist(subtract_minimum(Minimum), NumbersNoZero, NumbersSubtracted),
    succ(OperationsCounter, OperationsCounterNext), 
    delete(NumbersSubtracted, 0, NumbersSubtractedNoZero),
    zero_array(NumbersSubtractedNoZero, OperationsCounterNext, Operations).