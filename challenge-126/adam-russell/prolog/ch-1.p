:-initialization(main).

has_1(N):-
    number_codes(N, Codes),
    memberchk(49, Codes).  

count_numbers_without_1(N, Count):-
    count_numbers_without_1(N, 0, Count).  
count_numbers_without_1(1, Count, Count).  
count_numbers_without_1(N, CountAccum, Count):-
    \+ has_1(N),
    succ(CountAccum, C),
    N0 is N - 1,
    count_numbers_without_1(N0, C, Count).  
count_numbers_without_1(N, CountAccum, Count):-
    has_1(N),
    N0 is N - 1,
    count_numbers_without_1(N0, CountAccum, Count).  

main:-
    count_numbers_without_1(15, Count0),
    write(Count0), nl,
    count_numbers_without_1(25, Count1),
    write(Count1), nl,
    halt. 
