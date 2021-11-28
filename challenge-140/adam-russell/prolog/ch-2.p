:-initialization(main).

multiply(I, J, N):-
    between(1, I, Ith),
    between(1, J, Jth),
    N is Ith * Jth.

multiplication_table(I, J, Table):-
    bagof(N, multiply(I, J, N), Table).   

nth_from_table(I, J, K, N):-
    multiplication_table(I, J, Table),  
    msort(Table, SortedTable),   
    nth(K, SortedTable, N).  

main:-
    nth_from_table(2, 3, 4, N0),
    write(N0), nl, 
    nth_from_table(3, 3, 6, N1),
    write(N1), nl, 
    halt.   
