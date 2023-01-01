wiggle_sort(Unsorted, WiggleSorted):-
    wiggle_sort(1, Unsorted, WiggleSorted). 
wiggle_sort(I, [], []):-!.   
wiggle_sort(I, [A], [X | []]):-!.   
wiggle_sort(I, [A, B|T], [W, X | WiggleSorted]):-
    0 is mod(I, 2),    
    succ(I, J),
    ((A < B, W = B, X = A); (B =< A, W = A, X = B)),     
    wiggle_sort(J, T, WiggleSorted).  
wiggle_sort(I, [A, B|T], [W, X | WiggleSorted]):-
    1 is mod(I, 2),    
    succ(I, J), 
    ((A =< B, W = A, X = B); (B < A, W = B, X = A)),     
    wiggle_sort(J, T, WiggleSorted).  
