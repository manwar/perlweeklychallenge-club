#!/usr/bin/env perl

# Challenge 163
#
# Task 1: Sum Bitwise Operator
# Submitted by: Mohammad S Anwar
#
# You are given list positive numbers, @n.
#
# Write script to calculate the sum of bitwise & operator for all unique pairs.
# Example 1
#
# Input: @n = (1, 2, 3)
# Output: 3
#
# Since (1 & 2) + (2 & 3) + (1 & 3) => 0 + 2 + 1 =>  3.
#
# Example 2
#
# Input: @n = (2, 3, 4)
# Output: 2
#
# Since (2 & 3) + (2 & 4) + (3 & 4) => 2 + 0 + 0 =>  2.

use Modern::Perl;

sub sum_biwise_and {
    my(@n)=@_;
    my $sum=0;
    for my $i (0..$#n-1) {
        for my $j ($i+1..$#n) {
            $sum+=$n[$i]&$n[$j];
        }
    }
    return $sum;
}

say sum_biwise_and(@ARGV);
