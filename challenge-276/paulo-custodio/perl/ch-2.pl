#!/usr/bin/env perl

# Challenge 276
#
# Task 2: Maximum Frequency
# Submitted by: Mohammad Sajid Anwar
# You are given an array of positive integers, @ints.
#
# Write a script to return the total number of elements in the given array which have the highest frequency.
#
# Example 1
# Input: @ints = (1, 2, 2, 4, 1, 5)
# Ouput: 4
#
# The maximum frequency is 2.
# The elements 1 and 2 has the maximum frequency.
# Example 2
# Input: @ints = (1, 2, 3, 4, 5)
# Ouput: 5
#
# The maximum frequency is 1.
# The elements 1, 2, 3, 4 and 5 has the maximum frequency.

use Modern::Perl;
use List::Util 'max';

say max_freq(@ARGV);

sub max_freq {
    my(@ints) = @_;
    my %count; $count{$_}++ for @ints;
    my $max_count = max(values %count);
    my $max_freq = scalar grep {$count{$_} == $max_count} keys %count;
    return $max_freq;
}
