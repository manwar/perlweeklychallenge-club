#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #1 › Divide Integers
# Submitted by: Mohammad S Anwar
#
# You are given two integers $M and $N.
#
# Write a script to divide the given two integers i.e. $M / $N without
# using multiplication, division and mod operator and return the
# floor of the result of the division.
#
# Example 1:
#
# Input: $M = 5, $N = 2
# Output: 2
#
# Example 2:
#
# Input: $M = -5, $N = 2
# Output: -3
#
# Example 3:
#
# Input: $M = -5, $N = -2
# Output: 2

my ($m, $n) = @ARGV;

say divide($m, $n);

sub divide($m, $n) {
    # handle 0 values first
    return "undefined" if $n == 0;
    return 0 if $m == 0;

    # sign of the result
    my $sign = ($m < 0 && $n > 0) || ($m > 0 && $n < 0) ? -1 : 1;
    ($m, $n) = map {abs} ($m, $n);
    my $cnt = 0;
    while ($m >= $n) {
        $m -= $n;
        $cnt++;
    }

    if ($sign == -1 && $m > 0) {
        # floor is 1 below cnt when negative and there's a remainder
        return -($cnt+1);
    } else {
        return $cnt * $sign;
    }
}
