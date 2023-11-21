#!/usr/bin/env perl

# Challenge 244
#
# Task 2: Group Hero
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers representing the strength.
#
# Write a script to return the sum of the powers of all possible combinations;
# power is defined as the square of the largest number in a sequence, multiplied
# by the smallest.
#
# Example 1
#
# Input: @nums = (2, 1, 4)
# Output: 141
#
# Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
# Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
# Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
# Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
# Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
# Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
# Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16
#
# Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141

use Modern::Perl;
use List::Util qw( min max );
use Math::Combinatorics;

@ARGV or die "Usage: $0 n n n...\n";

sub calc_power {
    my(@n) = @_;
    return (max(@n)**2) * min(@n);
}

sub power {
    my(@n) = @_;
    my $sum = 0;
    for my $k (1 .. @n) {
        my $combinat = Math::Combinatorics->new(count => $k,
                                                data => [@n]);
        while(my @combo = $combinat->next_combination){
            $sum += calc_power(@combo);
        }
    }
    return $sum;
}

say power(@ARGV);
