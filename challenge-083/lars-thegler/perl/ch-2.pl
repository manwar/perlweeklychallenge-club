#! /usr/bin/env perl

use Modern::Perl;

# TASK #2 › Flip Array
# Submitted by: Mohammad S Anwar
# You are given an array @A of positive numbers.

# Write a script to flip the sign of some members of the given array so that the sum of the all members is minimum non-negative.

# Given an array of positive elements, you have to flip the sign of some of its elements such that the resultant sum of the elements of array should be minimum non-negative(as close to zero as possible). Return the minimum no. of elements whose sign needs to be flipped such that the resultant sum is minimum non-negative.

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

my @A = @ARGV;        # get an array of positive numbers
my $n = scalar @A;    # number of members

my $min_sum;          # minimum non-negative sum so far
my $min_sum_flips;    # minimum number of flips required to reach minimum sum

for my $M ( 0 .. ( 2**$n ) - 1 ) {

    my $m = $M;
    my @a = @A;
    my $i = 0;
    my $flips;
    while ($m) {
        if ( $m & 1 ) {    # flip each member where the is a '1' in the mask
            $a[$i] = -$a[$i];
            $flips += 1;
        }
        $m = $m >> 1;
        $i += 1;
    }

    my $sum;
    $sum += $a[$_] for 0 .. $#a;    # sum of all members

    next if $sum < 0;               # ignore negative results

    if ( not defined $min_sum or $sum <= $min_sum ) {
        $min_sum = $sum;
        if ( not defined $min_sum_flips or $flips < $min_sum_flips ) {
            $min_sum_flips = $flips;
        }
    }
}

say $min_sum_flips;
