#!/usr/bin/perl

# Challenge 082
#
# TASK #1 › Common Factors
# Submitted by: Niels van Dijke
# You are given 2 positive numbers $M and $N.
#
# Write a script to list all common factors of the given numbers.
#
# Example 1:
# Input:
#     $M = 12
#     $N = 18
#
# Output:
#     (1, 2, 3, 6)
#
# Explanation:
#     Factors of 12: 1, 2, 3, 4, 6
#     Factors of 18: 1, 2, 3, 6, 9
# Example 2:
# Input:
#     $M = 18
#     $N = 23
#
# Output:
#     (1)
#
# Explanation:
#     Factors of 18: 1, 2, 3, 6, 9
#     Factors of 23: 1

use strict;
use warnings;
use 5.030;

my($M, $N) = @ARGV;
my @common = common_factors($M, $N);
say "(", join(", ", @common), ")";

sub common_factors {
    my($a, $b) = @_;
    my @common;
    for (my $i = 1; 2*$i <= $a || 2*$i <= $b; $i++) {
        if (($a % $i)==0 && ($b % $i)==0) {
            push @common, $i;
        }
    }
    return @common;
}
