number_digits(X, L):-
    number_digits(X, 0, L).       
number_digits(0, L, L):- !, true.    
number_digits(X, S, A):- 
    L is S + 1,
    Z is div(X, 10),
    number_digits(Z, L, A).

number_list(X, L):-
    number_list(X, [], L).       
number_list(0, L, L):- !, true.    
number_list(X, S, A):- 
    Z is rem(X, 10),
    Y is div(X, 10),
    number_list(Y, [Z|S], A).    

list_number(L, N):-
    list_number(L, 0, N).
list_number([], N, N).    
list_number([Digit| T], Sum, N):-
    length(T, D),
    S is Sum + (Digit * (10 ^ D)),
    list_number(T, S, N).
    
permutation(List,[H|Permutation]):-delete(H,List,Rest),permutation(Rest,Permutation).
permutation([],[]).
   
delete(X,[X|T],T).
delete(X,[H|T],[H|NT]):-delete(X,T,NT).

combinations_of_length(_,[]).
combinations_of_length([X|T],[X|Combinations]):-
    combinations_of_length([X|T],Combinations).
combinations_of_length([_|T],[X|Combinations]):-
    combinations_of_length(T,[X|Combinations]).
    
find_numbers(Digits, Length, Max, Matches):-
    length(L, Length),
    combinations_of_length(Digits,L),
    permutation(L,LP),
    find_numbers(LP, Length, Max, [], Matches).

find_numbers([], _, _,Matches, Matches).
find_numbers(Digits, Length, Max, Acc, Matches):- 
    list_number(Digits, X),
    number_digits(X, L),
    L = Length,
    X < Max,
    find_numbers([], Length, Max, [X|Acc], Matches).
    
main:-
    setof(Matches, find_numbers([0,1,2,5], 2, 21, Matches), All_Matches),
    writeln(All_Matches),
    halt.
