twice_greater(X, Y, TwiceGreater):-
    X \== Y,
    TwiceY is 2 * Y,
    X >= TwiceY,
    TwiceGreater = -1.
twice_greater(X, Y, TwiceGreater):-
    TwiceY is 2 * Y,
    X < TwiceY,
    TwiceGreater = 1.
    
twice_largest(List):-
    max_list(List, Max),
    maplist(twice_greater(Max), List, TwiceGreater),
    delete(TwiceGreater, -1, TwiceGreaterOneDeleted), 
    length(TwiceGreaterOneDeleted, TwiceGreaterOneDeletedLength),
    TwiceGreaterOneDeletedLength == 1, !.
    