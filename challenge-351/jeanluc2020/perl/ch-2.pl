#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-351/#TASK2
#
# Task 2: Arithmetic Progression
# ==============================
#
# You are given an array of numbers.
#
# Write a script to return true if the given array can be re-arranged to form
# an arithmetic progression, otherwise return false.
#
### A sequence of numbers is called an arithmetic progression if the difference
### between any two consecutive elements is the same.
#
## Example 1
##
## Input: @num = (1, 3, 5, 7, 9)
## Output: true
##
## Already AP with common difference 2.
#
#
## Example 2
##
## Input: @num = (9, 1, 7, 5, 3)
## Output: true
##
## The given array re-arranged like (1, 3, 5, 7, 9) with common difference 2.
#
#
## Example 3
##
## Input: @num = (1, 2, 4, 8, 16)
## Output: false
##
## This is geometric progression and not arithmetic progression.
#
#
## Example 4
##
## Input: @num = (5, -1, 3, 1, -3)
## Output: true
##
## The given array re-arranged like (-3, -1, 1, 3, 5) with common difference 2.
#
#
## Example 5
##
## Input: @num = (1.5, 3, 0, 4.5, 6)
## Output: true
##
## The given array re-arranged like (0, 1.5, 3, 4.5, 6) with common difference 1.5.
#
############################################################
##
## discussion
##
############################################################
#
# We need to sort the elements to check whether they form an arithmetic
# progression. Then we check whether the difference of two subsequent
# numbers is always the same.

use v5.36;

arithmetic_progression(1, 3, 5, 7, 9);
arithmetic_progression(9, 1, 7, 5, 3);
arithmetic_progression(1, 2, 4, 8, 16);
arithmetic_progression(5, -1, 3, 1, -3);
arithmetic_progression(1.5, 3, 0, 4.5, 6);

sub arithmetic_progression(@num) {
    say "Input: (" . join(", ", @num) . ")";
    my @sorted = sort { $a <=> $b } @num;
    my $diff = $sorted[1] - $sorted[0];
    foreach my $index (0..$#sorted-1) {
        if($sorted[$index+1] - $sorted[$index] != $diff) {
            return say "Output: false";
        }
    }
    say "Output: true";
}
