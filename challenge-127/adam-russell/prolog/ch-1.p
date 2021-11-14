:-initialization(main).

conflicts(List0, List1):-
    member(X, List0),
    member(X, List1).  

disjoint(List0, List1):-
    \+ conflicts(List0, List1). 

main:-
    ((disjoint([1, 2, 5, 3, 4], [4, 6, 7, 8, 9]), write(1)); (write(0))), 
    nl,
    ((disjoint([1, 3, 5, 7, 9], [0, 2, 4, 6, 8]), write(1)); (write(0))), 
    nl,
    halt.  
