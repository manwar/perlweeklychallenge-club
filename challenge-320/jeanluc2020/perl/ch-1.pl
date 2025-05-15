#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-320/#TASK1
#
# Task 1: Maximum Count
# =====================
#
# You are given an array of integers.
#
# Write a script to return the maximum between the number of positive and
# negative integers. Zero is neither positive nor negative.
#
## Example 1
##
## Input: @ints = (-3, -2, -1, 1, 2, 3)
## Output: 3
##
## There are 3 positive integers.
## There are 3 negative integers.
## The maximum between 3 and 3 is 3.
#
#
## Example 2
##
## Input: @ints = (-2, -1, 0, 0, 1)
## Output: 2
##
## There are 1 positive integers.
## There are 2 negative integers.
## The maximum between 2 and 1 is 2.
#
#
## Example 3
##
## Input: @ints = (1, 2, 3, 4)
## Output: 4
##
## There are 4 positive integers.
## There are 0 negative integers.
## The maximum between 4 and 0 is 4.
#
############################################################
##
## discussion
##
############################################################
#
# We just count the positive and the negative integers.
# Then we look which of these two numbers is bigger.

use v5.36;

maximum_count(-3, -2, -1, 1, 2, 3);
maximum_count(-2, -1, 0, 0, 1);
maximum_count(1, 2, 3, 4);

sub maximum_count(@ints) {
    say "Input: (" . join(", ", @ints) . ")";
    my $neg = 0;
    my $pos = 0;
    foreach my $elem (@ints) {
        if($elem > 0) {
            $pos++;
        } elsif ( $elem < 0 ) {
            $neg++;
        }
    }
    if($neg > $pos) {
        say "Output: $neg";
    } else {
        say "Output: $pos";
    }
}
