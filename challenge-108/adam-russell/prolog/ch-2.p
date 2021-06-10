:-initialization(main).

addElement(Element, [FirstList | OtherLists], [ [Element|FirstList] | OtherLists]).
addElement(Element, [FirstList | OtherLists], [ FirstList | Temp] ):- 
    addElement(Element, OtherLists, Temp).

partition([Single], [[Single]]).
partition([First|Others], [[First] | Result]) :-
    partition(Others, Result).
partition([First|Others], Result) :-
    partition(Others, Temp),
    addElement(First, Temp, Result).

bell_numbers(N):-
    \+ N == 0,  
    N < 10,
    length(L0, N), 
    setof(P, partition(L0, P), Partitions), 
    length(Partitions, L),
    write('B_'), write(N), write(': '), write(L), nl,
    N0 is N + 1, 
    bell_numbers(N0).   
bell_numbers(N):-
    N == 0,
    write('B_'), write(N), write(': '), write(1), nl,
    N0 is N + 1,
    bell_numbers(N0).     
bell_numbers(_).   

main:-
    bell_numbers(0), 
    halt.    
