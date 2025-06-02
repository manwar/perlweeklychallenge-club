# Task 1 of Week 324
# The Weekly Challenge
# https://theweeklychallenge.org/blog/perl-weekly-challenge-324/#TASK1

# Note: the $r input from the task description is redundant
# and is not used in the solution.

# Test run:
# $ raku ch-1.raku 
# ((1 2) (3 4))
# ((1 2 3))
# ((1) (2) (3) (4))

say solve([1, 2, 3, 4], 2);
say solve([1, 2, 3], 3);
say solve([1, 2, 3, 4], 1);


sub solve(@data, $width) {
    return @data.rotor($width);
}
