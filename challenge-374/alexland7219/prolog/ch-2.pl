% TASK 2

% You are given a string containing 0-9 digits only.

% Write a script to return the largest number with 
% all digits the same in the given string.

use_module(library(lists)).

to_rep_num(Str, Num) :-
    string_chars(Str, L),
    list_to_set(L, Chs),
    length(Chs, 1),
    number_string(Num, Str).

lsdn(Goal, S) :-
    findall(
        N,
        (sub_string(S, _, _, _, X), to_rep_num(X, N)), 
        Nums
    ),
    max_list(Nums, Goal).

% Run the test suite:
% swipl -g run_tests -t halt ch-2.pl

:- begin_tests(lsdn).

test(1) :- lsdn(X, "6777133339"), X = 3333.
test(2) :- lsdn(X, "1200034"), X = 4.
test(3) :- lsdn(X, "44221155"), X = 55.
test(4) :- lsdn(X, "88888"), X = 88888.
test(5) :- lsdn(X, "11122233"), X = 222.

:- end_tests(lsdn).