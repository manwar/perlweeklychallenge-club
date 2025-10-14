# Task 1 of The Weekly Challenge 343
# https://theweeklychallenge.org/blog/perl-weekly-challenge-343/#TASK1

say dist [4, 2, -1, 3, -2]; # 1
say dist [-5, 5, -3, 3, -1, 1]; # 1
say dist [7, -3, 0, 2, -8]; # 0
say dist [-2, -5, -1, -8]; # 1
say dist [-2, 2, -4, 4, -1, 1]; # 1

sub dist(@data) {
    @data>>.abs.min
}
