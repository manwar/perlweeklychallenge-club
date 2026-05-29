% TASK 1

% You are given two array of strings.

% Write a script to return the number of strings
% that appear exactly once in each of the two given arrays.
% String comparison is case sensitive.

:- use_module(library(lists)).

single_common(L1, L2, N) :-
    findall(
        X,
        (
            select(X, L1, R1),
            select(X, L2, R2),
            \+ member(X, R1),
            \+ member(X, R2)
        ),
        Bag
    ),
    length(Bag, N).

% Run the test suite:
% swipl -g run_tests -t halt ch-1.pl

:- begin_tests(single_common).

test(1) :- findall(N, single_common(["apple","banana","cherry"], ["banana","cherry","date"], N), Bag), Bag = [2].
test(2) :- findall(N, single_common(["a","ab","abc"], ["a","a","ab","abc"], N), Bag), Bag = [2].
test(3) :- findall(N, single_common(["orange","lemon"], ["grape","melon"], N), Bag), Bag = [0].
test(4) :- findall(N, single_common(["test","test","demo"], ["test","demo","demo"], N), Bag), Bag = [0].
test(5) :- findall(N, single_common(["Hello","world"], ["hello","world"], N), Bag), Bag = [1].

:- end_tests(single_common).
