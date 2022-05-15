
pdi(0, Total_, Total):-
    Total is round(mod(Total_, 10) ** 2). 
pdi(N, Total_, Total):-
    N_ is N // 10,
    Total__ is round(mod(Total_, 10) ** 2), 
    pdi(N_, Total__, Total).
pdi(N, Total):-
    pdi(N, 0, Total).

%happy(0, _).
happy(1, _).
happy(N, Seen):-
    \+ member(N, Seen),
    pdi(N, Total),
    N_ is Total,
    happy(N_, [N|Seen]).
happy(N, Seen):-
    member(N, Seen), !, fail.
happy(N):-
    happy(N, []).
