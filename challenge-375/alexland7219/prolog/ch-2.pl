% TASK 2

% You are given a number and a digit (k).

% Write a script to find the K-Beauty of the given number.
% The K-Beauty of an integer number is defined as the
% number of substrings of given number when it is read
% as a string has length of ‘k’ and is a divisor of given number.

kbeauty(Num, K, Res) :-
    number_string(Num, NumStr),
    findall(
        Cand,
        (
            sub_string(NumStr, _, K, _, SubStr),
            number_string(Cand, SubStr),
            0 is Num mod Cand
        ),
        Bag
    ),
    length(Bag, Res).

% Run the test suite:
% swipl -g run_tests -t halt ch-2.pl

:- begin_tests(kbeauty).

test(1) :- findall(X, kbeauty(240, 2, X), Bag), Bag = [2].
test(2) :- findall(X, kbeauty(1020, 2, X), Bag), Bag = [3].
test(3) :- findall(X, kbeauty(444, 2, X), Bag), Bag = [0].
test(4) :- findall(X, kbeauty(17, 2, X), Bag), Bag = [1].
test(5) :- findall(X, kbeauty(123, 1, X), Bag), Bag = [2].

:- end_tests(kbeauty).
