#!/usr/bin/perl

# Challenge 090
# TASK #2 › Ethiopian Multiplication
# Submitted by: Mohammad S Anwar
# You are given two positive numbers $a and $b.
#
# Write a script to demonstrate Ethiopian Multiplication using the given numbers.

# The solution is just as described in the algorithm.

use strict;
use warnings;

my($a, $b) = @ARGV;

my $mul = 0;
while (1) {
    $mul += $b if ($a & 1) != 0;
    last if $a <= 1;
    $a >>= 1; $b <<= 1;
}

print $mul, "\n";
