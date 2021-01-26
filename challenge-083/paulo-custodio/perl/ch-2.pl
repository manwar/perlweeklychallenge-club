#!/usr/bin/perl

# Challenge 083
#
# TASK #2 › Flip Array
# Submitted by: Mohammad S Anwar
# You are given an array @A of positive numbers.
#
# Write a script to flip the sign of some members of the given array so that
# the sum of the all members is minimum non-negative.
#
# Given an array of positive elements, you have to flip the sign of some of
# its elements such that the resultant sum of the elements of array should be
# minimum non-negative(as close to zero as possible). Return the minimum no. of
# elements whose sign needs to be flipped such that the resultant sum is minimum
# non-negative.
#
# Example 1:
# Input: @A = (3, 10, 8)
# Output: 1
# Explanation:
# Flipping the sign of just one element 10 gives the result 1 i.e. (3) + (-10) + (8) = 1
# Example 2:
# Input: @A = (12, 2, 10)
# Output: 1
# Explanation:
# Flipping the sign of just one element 12 gives the result 0 i.e. (-12) + (2) + (10) = 0

use strict;
use warnings;
use 5.030;

my @A = @ARGV;
say count_flips(@A);


sub count_flips {
    my(@a) = @_;

    # setup initial conditions
    my @sign = (1) x scalar(@a);
    my $min_flips = 0;
    my $min_sum = sumprod(\@a, \@sign);

    while (next_flip(\@sign)) {
        my $sum = sumprod(\@a, \@sign);
        if ($sum >= 0) {
            my $flips = scalar(grep {$_==-1} @sign);
            if ($sum < $min_sum) {
                ($min_sum, $min_flips) = ($sum, $flips);
            }
            elsif ($sum == $min_sum && $flips < $min_flips) {
                ($min_sum, $min_flips) = ($sum, $flips);
            }
        }
    }
    return $min_flips;
}

# odometer-style sign flipper
sub next_flip {
    my($sign) = @_;
    for my $i (0 .. $#{$sign}) {
        if ($sign->[$i] == 1) {
            $sign->[$i] = -1;
            return 1;
        }
        else {
            $sign->[$i] = 1;
        }
    }
    return 0;
}

sub sumprod {
    my($a, $sign) = @_;
    my $sum = 0;
    for my $i (0 .. $#{$a}) {
        $sum += $a->[$i]*$sign->[$i];
    }
    return $sum;
}
