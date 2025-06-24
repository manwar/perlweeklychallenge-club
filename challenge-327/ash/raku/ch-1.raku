# Task 1 of the Weekly Challenge 327
# https://theweeklychallenge.org/blog/perl-weekly-challenge-327/#TASK1

say missing-numbers(1, 2, 1, 3, 2, 5); # 4, 6
say missing-numbers(1, 1, 1); # 2, 3
say missing-numbers(2, 2, 1); # 3

sub missing-numbers(*@data) {
    (1 .. @data.elems) (-) @data
}
