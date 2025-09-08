# Task 2 of The Weekly Challenge 338
# https://theweeklychallenge.org/blog/perl-weekly-challenge-338/#TASK2

say max-distance([4, 5, 7], [9, 1, 3, 4]); # 6
say max-distance([2, 3, 5, 4], [3, 2, 5, 5, 8, 7]); # 6
say max-distance([2, 1, 11, 3], [2, 5, 10, 2]); # 9
say max-distance([1, 2, 3], [3, 2, 1]); # 2
say max-distance([1, 0, 2, 3], [5, 0]); # 5

sub max-distance(@a, @b) {
    ((@a X @b).map: {abs([-] $_)}).max
}
