:-initialization(main).

pdi(0, Total, Total). 
pdi(N, Total_, Total):-
    N_ is N // 10,
    Total__ is Total_ + round(mod(N, 10) ** 2), 
    pdi(N_, Total__, Total).
pdi(N, Total):-
    pdi(N, 0, Total).

happy(1, _).
happy(N, Seen):-
    \+ member(N, Seen),
    pdi(N, Total),!,
    N_ is Total,
    happy(N_, [N|Seen]).
happy(N):-
    happy(N, []).

happy(_) --> [].
happy(Seen) --> [X], {between(1, 100, X), \+ member(X, Seen), happy(X)}, happy([X|Seen]).

main:-
    length(Happy, 8),
    phrase(happy([]), Happy),
    write(Happy), nl.
