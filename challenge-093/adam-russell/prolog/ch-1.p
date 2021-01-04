/*
* You are given set of co-ordinates N.
* Write a script to count maximum points 
* on a straight line when given co-ordinates 
* plotted on 2-d plane.
*/
:-initialization(main).

triangle_area(Points, Area):-
    [[X1, Y1], [X2, Y2], [X3, Y3]] = Points,
    Area is (X1 * (Y2 - Y3)) + (X2 * (Y3 - Y1)) + (X3 * (Y1 - Y2)).

collinear_points(Points, CollinearPoints):-
    member(A, Points),
    member(B, Points),
    member(C, Points),
    A \== B, A \== C, B \== C,
    triangle_area([A, B, C], Area),
    Area == 0,
    CollinearPoints = [A, B, C].

main:-
    N = [[5,3], [1,1], [2,2], [3,1], [1,3]],
    collinear_points(N, CollinearPoints),
    write(CollinearPoints), nl,
    halt.