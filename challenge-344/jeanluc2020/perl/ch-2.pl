#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-344/#TASK2
#
# Task 2: Array Formation
# =======================
#
# You are given two list: @source and @target.
#
# Write a script to see if you can build the exact @target by putting these
# smaller lists from @source together in some order. You cannot break apart or
# change the order inside any of the smaller lists in @source.
#
## Example 1
##
## Input: @source = ([2,3], [1], [4])
##        @target = (1, 2, 3, 4)
## Output: true
##
## Use in the order: [1], [2,3], [4]
#
#
## Example 2
##
## Input: @source = ([1,3], [2,4])
##        @target = (1, 2, 3, 4)
## Output: false
#
#
## Example 3
##
## Input: @source = ([9,1], [5,8], [2])
##        @target = (5, 8, 2, 9, 1)
## Output: true
##
## Use in the order: [5,8], [2], [9,1]
#
#
## Example 4
##
## Input: @source = ([1], [3])
##        @target = (1, 2, 3)
## Output: false
##
## Missing number: 2
#
#
## Example 5
##
## Input: @source = ([7,4,6])
##        @target = (7, 4, 6)
## Output: true
##
## Use in the order: [7, 4, 6]
#
############################################################
##
## discussion
##
############################################################
#
# We check all possible permutations of the source arrays. If
# any permutation has all numbers in the same order than the
# target array, we can return true since we found a solution.
# Otherwise, we return false.

use v5.36;
use Algorithm::Permute;

array_formation([[2,3], [1], [4]], [1, 2, 3, 4]);
array_formation([[1,3], [2,4]], [1, 2, 3, 4]);
array_formation([[9,1], [5,8], [2]], [5, 8, 2, 9, 1]);
array_formation([[1], [3]], [1, 2, 3]);
array_formation([[7,4,6]], [7, 4, 6]);

sub array_formation($source, $target) {
    say "Input: (" . join(", ", map { "[" . join(", ", @$_) .  "]" } @$source)
            . "), (" . join(", ", @$target) . ")";
    my $p_iterator = Algorithm::Permute->new ( $source );
    while(my @perm = $p_iterator->next) {
        my @tmp = ();
        foreach my $list (@perm) {
            push @tmp, @$list;
        }
        if(equals(\@tmp, $target)) {
            return say "Output: true";
        }
    }
    say "Output: false";
}

sub equals($left, $right) {
    return 0 unless scalar(@$left) == scalar(@$right);
    foreach my $i (0..scalar(@$left)-1) {
        return 0 if $left->[$i] != $right->[$i];
    }
    return 1;
}
