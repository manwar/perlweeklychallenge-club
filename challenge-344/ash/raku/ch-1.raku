# Task 1 of the Weekly Challenge 344
# https://theweeklychallenge.org/blog/perl-weekly-challenge-344/#TASK1

say add-val((1, 2, 3, 4), 12); # (1 2 4 6)
say add-val((2, 7, 4), 181); # (4 5 5)
say add-val((9, 9, 9), 1); # (1 0 0 0)
say add-val((1, 0, 0, 0, 0), 9999); # (1 9 9 9 9)
say add-val((0,), 1000); # (1 0 0 0)

sub add-val(@ints, $x) {
    (@ints.join + $x).comb
}
