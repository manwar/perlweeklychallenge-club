#!/usr/bin/env perl

# Task 1: Reverse Pairs
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# 
# Write a script to return the number of reverse pairs in the given array.
# 
# A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b) nums[i] > 2 * nums[j].
# Example 1
# 
# Input: @nums = (1, 3, 2, 3, 1)
# Output: 2
# 
# (1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
# (3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1
#
# Example 2
#
# Input: @nums = (2, 4, 3, 5, 1)
# Output: 3
#
# (1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
# (2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
# (3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    [ 1, 3, 2, 3, 1 ],
    [ 2, 4, 3, 5, 1 ],
);

sub get_reverse_pairs {
    my $nums = shift;
    my $length = scalar @$nums;
    my @pairs;
    for (my $i = 0; $i < $length - 1; $i++) {
        for (my $j = $i + 1; $j < $length; $j++) {
            push(@pairs, [$i,$j]) if ( $nums->[$i] > 2 * $nums->[$j]) 
        }
    }
    
    return \@pairs;
}

for my $elements (@examples) {
    my $reverse_pairs = get_reverse_pairs $elements;

    say 'Input : @nums = ', dump(@$elements);
    say 'Output : ', scalar @$reverse_pairs;
    foreach my $pair (@$reverse_pairs) {
        my $i = $pair->[0];
        my $j = $pair->[1];
        say sprintf "%s => nums[%d] = %d, nums[%d] = %d, %d > 2 * %d", dump(@$pair), $i, $elements->[$i], $j, $elements->[$j], $elements->[$i], $elements->[$j] 
    }
    say ' ';
}
