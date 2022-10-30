count_zero(X, Y, Count):-
    count_zero(X, Y, 0, Count), !.
count_zero(0, 0, Count, Count).    
count_zero(X, Y, CountAccum, Count):-
    X > Y,
    XNew is X - Y,
    succ(CountAccum, CountAccumSucc), 
    count_zero(XNew, Y, CountAccumSucc, Count).
count_zero(X, Y, CountAccum, Count):-
    Y > X,
    YNew is Y - X,
    succ(CountAccum, CountAccumSucc), 
    count_zero(X, YNew, CountAccumSucc, Count).    
count_zero(X, Y, CountAccum, Count):-
    X == Y,
    XNew is X - Y,
    YNew is Y - X,
    succ(CountAccum, CountAccumSucc), 
    count_zero(XNew, YNew, CountAccumSucc, Count).       