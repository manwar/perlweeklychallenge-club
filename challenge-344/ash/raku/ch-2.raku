# Task 2 of the Weekly Challenge 344
# https://theweeklychallenge.org/blog/perl-weekly-challenge-344/#TASK2

say can-form-array(([2,3], [1], [4]), (1, 2, 3, 4)); # True
say can-form-array(([1,3], [2,4]), (1, 2, 3, 4)); # False
say can-form-array(([9,1], [5,8], [2]), (5, 8, 2, 9, 1)); # True
say can-form-array(([1], [3]), (1, 2, 3)); # False
say can-form-array(([7,4,6]), (7, 4, 6)); # True

sub can-form-array(@source, @target) {
    @target ~~ any(@source.permutations>>.flat)
}
