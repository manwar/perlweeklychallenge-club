# Task 1 of the Weekly Challenge 334
# https://theweeklychallenge.org/blog/perl-weekly-challenge-334/#TASK1

say solve([-2, 0, 3, -5, 2, -1], 0, 2); # 1
say solve([1, -2, 3, -4, 5],     1, 3); # -3
say solve([1, 0, 2, -1, 3],      3, 4); # 2
say solve([-5, 4, -3, 2, -1, 0], 0, 3); # -2
say solve([-1, 0, 2, -3, -2, 1], 0, 2); # 1

sub solve(@data, $beg, $end) {
    [+] @data[$beg..$end]
}
