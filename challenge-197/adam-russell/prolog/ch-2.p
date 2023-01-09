wiggle_sort(Unsorted, WiggleSorted):-
    min_list(Unsorted, Start),
    select(Start, Unsorted, UnsortedNoStart),
    wiggle_sort(1, Start, UnsortedNoStart, WiggleSortedPartial),
    WiggleSorted = [Start|WiggleSortedPartial]. 
wiggle_sort(_, _, [], []):-!.   
wiggle_sort(_, _, [A], [A | []]):-!.   
wiggle_sort(I, Previous, Unsorted, [A | WiggleSorted]):-
    1 is mod(I, 2),    
    succ(I, J),
    member(A, Unsorted),
    A > Previous,
    select(A, Unsorted, UnsortedNoA),
    wiggle_sort(J, A, UnsortedNoA, WiggleSorted).  
wiggle_sort(I, Previous, Unsorted, [A | WiggleSorted]):-
    0 is mod(I, 2),    
    succ(I, J), 
    member(A, Unsorted),
    A < Previous,
    select(A, Unsorted, UnsortedNoA),
    wiggle_sort(J, A, UnsortedNoA, WiggleSorted).   