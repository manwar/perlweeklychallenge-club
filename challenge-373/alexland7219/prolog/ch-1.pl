% TASK 1

% You are given two arrays of strings.
% Write a script to return true if the two given 
% array represent the same strings otherwise false.

flatten([], "").
flatten([X|Xs], Y) :-
    flatten(Xs, Z),
    string_concat(X, Z, Y).

equal_list(X, Y) :-
    flatten(X, Xs),
    flatten(Y, Ys),
    Xs = Ys.

% Run the test suite:
% swipl -g run_tests -t halt ch-1.pl

:- begin_tests(equal_list).

test(1) :- 
    equal_list(["ab", "c"], ["a", "bc"]).

test(2) :- 
    equal_list(["a", "b", "c"], ["a", "bc"]).

test(3, fail) :- 
    equal_list(["a", "bc"], ["a", "c", "b"]).

test(4) :-
    equal_list(["ab", "c"], ["", "a", "bc"]).

test(5) :-
    equal_list(["p", "e", "r", "l"], ["perl"]).

:- end_tests(equal_list).