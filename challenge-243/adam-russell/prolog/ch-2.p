floor_sum_pair(X, Y, Z):-
    Z is floor(X / Y).

floor_sum(Integers, FloorSum):-
    floor_sum(Integers, Integers, FloorSum).
floor_sum([], _, 0).    
floor_sum([H|T], L, FloorSum):-
    floor_sum(T, L, F),
    maplist(floor_sum_pair(H), L, FS),
    sum_list(FS, Sum),
    FloorSum is F + Sum.        