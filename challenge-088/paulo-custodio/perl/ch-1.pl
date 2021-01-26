#!/usr/bin/perl

# Challenge 088
#
# TASK #1 › Array of Product
# Submitted by: Mohammad S Anwar
# You are given an array of positive integers @N.
#
# Write a script to return an array @M where $M[i] is the product of all elements
# of @N except the index $N[i].
#
# Example 1:
# Input:
#     @N = (5, 2, 1, 4, 3)
# Output:
#     @M = (24, 60, 120, 30, 40)
#
#     $M[0] = 2 x 1 x 4 x 3 = 24
#     $M[1] = 5 x 1 x 4 x 3 = 60
#     $M[2] = 5 x 2 x 4 x 3 = 120
#     $M[3] = 5 x 2 x 1 x 3 = 30
#     $M[4] = 5 x 2 x 1 x 4 = 40
# Example 2:
# Input:
#     @N = (2, 1, 4, 3)
# Output:
#     @M = (12, 24, 6, 8)
#
#     $M[0] = 1 x 4 x 3 = 12
#     $M[1] = 2 x 4 x 3 = 24
#     $M[2] = 2 x 1 x 3 = 6
#     $M[3] = 2 x 1 x 4 = 8

use strict;
use warnings;
use 5.030;

my @N = @ARGV;
my @M = array_product(@N);
say "(", join(", ", @M), ")";

sub array_product {
    my(@n) = @_;
    my @m = (1) x scalar(@n);               # initialize the products to 1
    for my $i (0 .. $#n) {
        for my $j (0 .. $#m) {
            $m[$j] *= $n[$i] if $i != $j;   # multiply if not the same index
        }
    }
    return @m;
}
