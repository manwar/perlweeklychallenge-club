#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);

# TASK #2 › Flip Array
# Submitted by: Mohammad S Anwar
#
# You are given an array @A of positive numbers.
#
# Write a script to flip the sign of some members of the given array
# so that the sum of the all members is minimum non-negative.
#
# Given an array of positive elements, you have to flip the sign of
# some of its elements such that the resultant sum of the elements of
# array should be minimum non-negative(as close to zero as
# possible). Return the minimum no. of elements whose sign needs to be
# flipped such that the resultant sum is minimum non-negative.

my @a = @ARGV;

my $min_sum = 1e300;
my $min_num = 1e300;

for my $bits (0 .. 2**@a - 1) {
    my $sum = 0;
    my $num = 0;
    for my $i (0..$#a) {
        if ($bits & 2**$i) {
            $sum += $a[$i];
        } else {
            $sum -= $a[$i];
            $num++;
        }
    }
    if (0 <= $sum < $min_sum) {
        $min_sum = $sum;
        $min_num = $num;
    } elsif ($sum == $min_sum && $num < $min_num) {
        $min_num = $num;
    }
}

say "min sum = $min_sum min num = $min_num";

