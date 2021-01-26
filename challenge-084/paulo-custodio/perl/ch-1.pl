#!/usr/bin/perl

# Challenge 084
#
# TASK #1 › Reverse Integer
# Submitted by: Mohammad S Anwar
# You are given an integer $N.
#
# Write a script to reverse the given integer and print the result. Print 0 if
# the result doesn’t fit in 32-bit signed integer.
#
# The number 2,147,483,647 is the maximum positive value for a 32-bit signed binary
# integer in computing.
#
# Example 1:
# Input: 1234
# Output: 4321
# Example 2:
# Input: -1234
# Output: -4321
# Example 3:
# Input: 1231230512
# Output: 0

use strict;
use warnings;
use 5.030;

my($n) = @ARGV;
say reverse_int($n);

sub reverse_int {
    my($n) = @_;
    return 0 if ($n < -0x80000000 || $n > 0x7fffffff);
    my $rev = 0;
    my $sign = ($n < 0) ? -1 : 1;
    $n = abs($n);
    while ($n > 0) {
        $rev = 10 * $rev + ($n % 10);
        $n = int($n / 10);
    }
    $rev *= $sign;
    return $rev;
}
