smaller([], _, 0).
smaller([H|Integers], X, Y):-
    smaller(Integers, X, Y0),
    ((X > H, succ(Y0, Y));
     (X =< H, Y = Y0)).
    
count_smaller(Integers, CountSmaller):-
    maplist(smaller(Integers), Integers, CountSmaller).