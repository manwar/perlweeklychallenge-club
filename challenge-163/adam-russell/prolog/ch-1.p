and(N, X, And):-
    And is N /\ X.
sum_and([], 0).
sum_and([H|T], SumAnd):-
    sum_and(T, Sum),
    maplist(and(H), T, Ands),
    sum_list(Ands, AndSum),
    SumAnd is Sum + AndSum.
