# Task 2 of the Weekly Challenge 320
# https://theweeklychallenge.org/blog/perl-weekly-challenge-320/#TASK2

my @ints = 1, 23, 4, 5; # 18
# my @ints = 1, 2, 3, 4, 5; # 0
# my @ints = 1, 2, 34; # 27

say abs(@ints.sum - @ints.comb.sum);
