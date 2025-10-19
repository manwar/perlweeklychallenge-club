#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-343/#TASK1
#
# Task 1: Zero Friend
# ===================
#
# You are given a list of numbers.
#
# Find the number that is closest to zero and return its distance to zero.
#
## Example 1
##
## Input: @nums = (4, 2, -1, 3, -2)
## Output: 1
##
## Values closest to 0: -1 and 2 (distance = 1 and 2)
#
#
## Example 2
##
## Input: @nums = (-5, 5, -3, 3, -1, 1)
## Output: 1
##
## Values closest to 0: -1 and 1 (distance = 1)
#
#
## Example 3
##
## Input: @ums = (7, -3, 0, 2, -8)
## Output: 0
##
## Values closest to 0: 0 (distance = 0)
## Exact zero wins regardless of other close values.
#
#
## Example 4
##
## Input: @nums = (-2, -5, -1, -8)
## Output: 1
##
## Values closest to 0: -1 and -2 (distance = 1 and 2)
#
#
## Example 5
##
## Input: @nums = (-2, 2, -4, 4, -1, 1)
## Output: 1
##
## Values closest to 0: -1 and 1 (distance = 1)
#
############################################################
##
## discussion
##
############################################################
#
# The distance to zero is exactly the absolute value of the number.
# So we just need to find the smallest absolute value in the array.
#

use v5.36;

zero_friend(4, 2, -1, 3, -2);
zero_friend(-5, 5, -3, 3, -1, 1);
zero_friend(7, -3, 0, 2, -8);
zero_friend(-2, -5, -1, -8);
zero_friend(-2, 2, -4, 4, -1, 1);

sub zero_friend(@nums) {
    say "Input: (" . join(", ", @nums) . ")";
    my $result = abs($nums[0]);
    foreach my $elem (@nums) {
        $result = abs($elem) if abs($elem) < $result;
    }
    say "Output: $result";
}
