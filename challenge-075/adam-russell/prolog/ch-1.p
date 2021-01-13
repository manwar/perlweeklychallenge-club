member(X,[X|_]).
member(X,[_|T]) :- member(X,T).

coins([1,2,4]).

sum(Coins):-
    sum([], Coins, 0).

sum(Coins, Coins, 6). 

sum(Partial, Coins, Sum):-   
    Sum < 6, 
    coins(L),
    member(X,L),
    S is Sum + X,
    sum([X | Partial], Coins, S).  

main:-
    findall(Coins,sum(Coins), C),
    writeln(C),
    halt. 