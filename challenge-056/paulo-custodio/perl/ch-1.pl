#!/usr/bin/env perl

# Challenge 056
#
# TASK #1
# Diff-K
# You are given an array @N of positive integers (sorted) and another non
# negative integer k.
#
# Write a script to find if there exists 2 indices i and j such that
# A[i] - A[j] = k and i != j.
#
# It should print the pairs of indices, if any such pairs exist.
#
# Example:
#
#     @N = (2, 7, 9)
#     $k = 2
# Output : 2,1

use Modern::Perl;

my($k, @n) = @ARGV;

for my $i (0 .. $#n-1) {
    for my $j ($i+1 .. $#n) {
        if (abs($n[$i]-$n[$j])==$k) {
            say "$i,$j";
        }
    }
}
