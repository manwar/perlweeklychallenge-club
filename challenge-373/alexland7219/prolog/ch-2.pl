% TASK 2

% You are given a list and a non-negative integer.

% Write a script to divide the given list into given 
% non-negative integer equal parts. Return -1 if the 
% integer is more than the size of the list.

use_module(library(lists)).

rev_length(X, L) :-
    length(L, X).

list_divided(-1, Init, N) :-
    length(Init, L),
    L < N, !.

list_divided(Goal, Init, N) :-
    length(Goal, N),
    append(Goal, Init),
    length(Init, L),
    Q is div(L, N), R is mod(L, N), P is Q+1,
    append(S1, S2, Goal), length(S1, R),
    maplist(rev_length(P), S1),
    maplist(rev_length(Q), S2), !.

% Run the test suite:
% swipl -g run_tests -t halt ch-2.pl

:- begin_tests(list_divided).

test(1) :- 
    findall(X, list_divided(X, [1, 2, 3, 4, 5], 2), Sols),
    Sols == [[[1, 2, 3], [4, 5]]].

test(2) :- 
    findall(X, list_divided(X, [1, 2, 3, 4, 5, 6], 3), Sols),
    Sols == [[[1, 2], [3, 4], [5, 6]]].

test(3) :- 
    findall(X, list_divided(X, [1, 2, 3], 2), Sols),
    Sols == [[[1, 2], [3]]].

test(4) :- 
    findall(X, list_divided(X, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5), Sols),
    Sols == [[[1, 2], [3, 4], [5, 6], [7, 8], [9, 10]]].

test(5) :- 
    findall(X, list_divided(X, [1, 2, 3], 4), Sols),
    Sols == [-1].

test(6) :- 
    findall(X, list_divided(X, [72,57,89,55,36,84,10,95,99,35], 7), Sols),
    Sols == [[[72, 57], [89, 55], [36, 84], [10], [95], [99], [35]]].

:- end_tests(list_divided).