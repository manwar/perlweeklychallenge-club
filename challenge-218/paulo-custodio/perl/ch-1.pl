#!/usr/bin/perl

# Challenge 218
#
# Task 1: Maximum Product
# Submitted by: Mohammad S Anwar
#
# You are given a list of 3 or more integers.
#
# Write a script to find the 3 integers whose product is the maximum and return it.
# Example 1
#
# Input: @list = (3, 1, 2)
# Output: 6
#
# 1 x 2 x 3 => 6
#
# Example 2
#
# Input: @list = (4, 1, 3, 2)
# Output: 24
#
# 2 x 3 x 4 => 24
#
# Example 3
#
# Input: @list = (-1, 0, 1, 3, 1)
# Output: 3
#
# 1 x 1 x 3 => 3
#
# Example 4
#
# Input: @list = (-8, 2, -9, 0, -4, 3)
# Output: 216
#
# -9 × -8 × 3 => 216

use Modern::Perl;

sub max_product {
    my(@N) = @_;
    return 0 if @N < 3;
    my $max = 0;
    for my $i (0 .. $#N-2) {
        for my $j ($i+1 .. $#N-1) {
            for my $k ($j+1 .. $#N) {
                my $prod = $N[$i]*$N[$j]*$N[$k];
                $max = $prod if $prod > $max;
            }
        }
    }
    return $max;
}

say max_product(@ARGV);
