:-initialization(main).

points --> [].
points --> point, points.
point  --> [0]; [1]; [2]; [3].

basketball_points(Points, Goal):-
    length(Points, Goal),
    phrase(points, Points),
    sum_list(Points, Goal).

zero_remove([], []).
zero_remove([H|T], [ZR_H|ZR_T]):-
    delete(H, 0, ZR_H),
    zero_remove(T, ZR_T).

main:-
    findall(Ps, basketball_points(Ps, 4), Points),
    zero_remove(Points, PointsZR), 
    sort(PointsZR, PointsZR_Unique),
    write(PointsZR_Unique), nl,
    halt.
