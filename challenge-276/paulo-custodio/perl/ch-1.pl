#!/usr/bin/env perl

# Challenge 276
#
# Task 1: Complete Day
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @hours.
#
# Write a script to return the number of pairs that forms a complete day.
#
# A complete day is defined as a time duration that is an exact multiple of 24 hours.
#
# Example 1
# Input: @hours = (12, 12, 30, 24, 24)
# Output: 2
#
# Pair 1: (12, 12)
# Pair 2: (24, 24)
# Example 2
# Input: @hours = (72, 48, 24, 5)
# Output: 3
#
# Pair 1: (72, 48)
# Pair 2: (72, 24)
# Pair 3: (48, 24)
# Example 3
# Input: @hours = (12, 18, 24)
# Output: 0

use Modern::Perl;

say complete_days(@ARGV);

sub complete_days {
    my(@hours) = @_;
    my $pairs = 0;
    for my $i (0 .. $#hours-1) {
        for my $j ($i+1 .. $#hours) {
            $pairs++ if ($hours[$i]+$hours[$j]) % 24 == 0;
        }
    }
    return $pairs;
}
