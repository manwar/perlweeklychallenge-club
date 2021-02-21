:-initialization(main).

minimum_sum(Triangle, Sum):-
    minimum_sum(Triangle, 1, 0, Sum).  
minimum_sum([H|[]], Index, PartialSum, Sum):-
    nth(Index, H, N),
    Sum is PartialSum + N.  
minimum_sum([H0, H1|T], Index, PartialSum, Sum):-
    nth(Index, H0, N0),
    PartialSum0 is PartialSum + N0,
    I0 is Index + 1, 
    nth(I0, H1, N1),
    nth(Index, H1, N2),
    N1 > N2,
    minimum_sum([H1|T], Index, PartialSum0, Sum). 
minimum_sum([H0, H1|T], Index, PartialSum, Sum):-
    nth(Index, H0, N0),
    PartialSum0 is PartialSum + N0,
    I0 is Index + 1, 
    nth(I0, H1, N1),
    nth(Index, H1, N2),
    N1 =< N2,
    minimum_sum([H1|T], I0, PartialSum0, Sum). 

main:-
    minimum_sum([[1], [2, 4], [6, 4, 9], [5, 1, 7, 2]], Sum0),  
    write(Sum0), nl, 
    minimum_sum([[3], [3, 1], [5, 2, 3], [4, 3, 1, 3]], Sum1), 
    write(Sum1), nl, 
    halt.  
