#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-325/#TASK1
#
# Task 1: Consecutive One
# =======================
#
# You are given a binary array containing only 0 or/and 1.
#
# Write a script to find out the maximum consecutive 1 in the given array.
#
## Example 1
##
## Input: @binary = (0, 1, 1, 0, 1, 1, 1)
## Output: 3
#
#
## Example 2
##
## Input: @binary = (0, 0, 0, 0)
## Output: 0
#
#
## Example 3
##
## Input: @binary = (1, 0, 1, 0, 1, 1)
## Output: 2
#
############################################################
##
## discussion
##
############################################################
#
# We need to keep track of the current consecutive number of 1s and
# of the longest streak so far in two variables. For each element
# we need to check whether it's a one or zero. In the latter case, we
# reset $current to 0, otherwise we add one to $current and if $current
# is bigger than the longest streak, we set that variable as well.
#

use v5.36;

consecutive_one(0, 1, 1, 0, 1, 1, 1);
consecutive_one(0, 0, 0, 0);
consecutive_one(1, 0, 1, 0, 1, 1);

sub consecutive_one( @binary ) {
    say "binary = (" . join(", ", @binary) . ")";
    my $longest = 0;
    my $current = 0;
    foreach my $elem (@binary) {
        if($elem) {
            $current++;
            if($current > $longest) {
                $longest = $current;
            }
        } else {
            $current = 0;
        }
    }
    say "Output: $longest";
}

