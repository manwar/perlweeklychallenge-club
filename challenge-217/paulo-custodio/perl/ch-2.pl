#!/usr/bin/env perl

# Challenge 217
#
# Task 2: Max Number
# Submitted by: Mohammad S Anwar
#
# You are given a list of positive integers.
#
# Write a script to concatenate the integers to form the highest possible value.
# Example 1:
#
# Input: @list = (1, 23)
# Output: 231
#
# Example 2:
#
# Input: @list = (10, 3, 2)
# Output: 3210
#
# Example 3:
#
# Input: @list = (31, 2, 4, 10)
# Output: 431210
#
# Example 4:
#
# Input: @list = (5, 11, 4, 1, 2)
# Output: 542111
#
# Example 5:
#
# Input: @list = (1, 10)
# Output: 110

use Modern::Perl;

sub by_largest {
    my($a, $b) = @_;

    if (substr($a,0,1) ne substr($b,0,1)) {
        return $b cmp $a;
    }
    else {
        return length($a) <=> length($b);
    }
}

say join '', sort {by_largest($a,$b)} @ARGV;
