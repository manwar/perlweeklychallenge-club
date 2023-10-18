:- use_module(library(lists)).
ch1(A,B):-append(A,R),append(B,R).

?- ch1(["ab","c"],["a","bc"]).
?- ch1(["ab","c"],["ac","b"]).
?- ch1(["ab","cd","e"],["abcde"]).
