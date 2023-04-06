#!/usr/bin/perl

# Challenge 188
#
# Task 1: Divisible Pairs
# Submitted by: Mohammad S Anwar
# You are given list of integers @list of size $n and divisor $k.
#
# Write a script to find out count of pairs in the given list that satisfies the
# following rules.
#
# The pair (i, j) is eligible if and only if
# a) 0 <= i < j < len(list)
# b) list[i] + list[j] is divisible by k
# Example 1
# Input: @list = (4, 5, 1, 6), $k = 2
# Output: 2
# Example 2
# Input: @list = (1, 2, 3, 4), $k = 2
# Output: 2
# Example 3
# Input: @list = (1, 3, 4, 5), $k = 3
# Output: 2
# Example 4
# Input: @list = (5, 1, 2, 3), $k = 4
# Output: 2
# Example 5
# Input: @list = (7, 2, 4, 5), $k = 4
# Output: 1

use Modern::Perl;

sub divisible_pairs {
    my(@n)=@_;
    my $k=pop @n;
    my $count=0;
    for my $i (0..$#n-1) {
        for my $j ($i+1..$#n) {
            if (($n[$i]+$n[$j])%$k==0) {
                $count++;
            }
        }
    }
    return $count;
}

say divisible_pairs(@ARGV);
