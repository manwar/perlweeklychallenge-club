# Task 1 of The Weekly Challenge 338
# https://theweeklychallenge.org/blog/perl-weekly-challenge-338/#TASK1

say max-sum([[4,  4, 4, 4],
             [10, 0, 0, 0],
             [2,  2, 2, 9]]); # 16

say max-sum([[1, 5],
             [7, 3],
             [3, 5]]); # 10

say max-sum([[1, 2, 3],
             [3, 2, 1]]); # 6

say max-sum([[2, 8, 7],
             [7, 1, 3],
             [1, 9, 5]]); # 17

say max-sum([[10, 20,  30],
             [5,  5,   5],
             [0,  100, 0],
             [25, 25,  25]]); # 100

sub max-sum(*@matrix) {
    @matrix>>.sum.max
}
