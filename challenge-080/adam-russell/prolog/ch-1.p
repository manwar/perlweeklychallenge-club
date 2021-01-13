/*
* You are given an unsorted list of integers N.
* Write a script to find out the smallest positive number missing.
*/
n([2, 0, -1]).

missing_smallest([H|T], X):-
    H >= 0,
    last(T, Last),
    between(H, Last, X),
    \+ member(X, [H|T]),
    !.
missing_smallest([_|T], X):-
    missing_smallest(T, X).


main:-
    n(N),
    sort(N, Sorted),
    missing_smallest(Sorted, Missing),
    writeln(Missing),
    halt.
    
    
