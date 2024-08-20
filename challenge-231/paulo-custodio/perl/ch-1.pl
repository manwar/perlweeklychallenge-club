#!/usr/bin/env perl

# Challenge 231
#
# Task 1: Min Max
# Submitted by: Mohammad S Anwar
# You are given an array of distinct integers.
#
# Write a script to find all elements that is neither minimum nor maximum.
# Return -1 if you can’t.
#
# Example 1
# Input: @ints = (3, 2, 1, 4)
# Output: (3, 2)
#
# The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither
# min nor max.
# Example 2
# Input: @ints = (3, 1)
# Output: -1
# Example 3
# Input: @ints = (2, 1, 3)
# Output: (2)
#
# The minimum is 1 and maximum is 3 in the given array. So 2 is neither
# min nor max.

use Modern::Perl;
use List::Util 'min', 'max';

say join " ", min_max(@ARGV);

sub min_max {
    my(@n) = @_;
    my $min = min(@n);
    my $max = max(@n);
    my @ret = grep {$_ != $min && $_ != $max} @n;
    return @ret ? @ret : -1;
}
