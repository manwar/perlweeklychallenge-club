sum(Coins):-
    sum([], Coins, 0).

sum(Coins, Coins, 5). 

sum(Partial, Coins, Sum):-   
    Sum < 5, 
    between(1, 5, X),
    S is Sum + X,
    sum([X | Partial], Coins, S).  

main:-
    findall(Coins, sum(Coins), C),
    maplist(msort, C, CS),
    sort(CS, CoinsSorted),
    write(CoinsSorted), nl,
    halt. 