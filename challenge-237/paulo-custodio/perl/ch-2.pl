#!/usr/bin/env perl

# Challenge 237
#
# Task 2: Maximise Greatness
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to permute the give array such that you get the maximum
# possible greatness.
#
#     To determine greatness, nums[i] < perm[i] where 0 <= i < nums.length
#
#
# Example 1
#
# Input: @nums = (1, 3, 5, 2, 1, 3, 1)
# Output: 4
#
# One possible permutation: (2, 5, 1, 3, 3, 1, 1) which returns 4 greatness as
# below:
# nums[0] < perm[0]
# nums[1] < perm[1]
# nums[3] < perm[3]
# nums[4] < perm[4]
#
# Example 2
#
# Input: @ints = (1, 2, 3, 4)
# Output: 3
#
# One possible permutation: (2, 3, 4, 1) which returns 3 greatness as below:
# nums[0] < perm[0]
# nums[1] < perm[1]
# nums[2] < perm[2]

use Modern::Perl;
use Math::Combinatorics;
use List::Util 'max';

my @nums = @ARGV;

my $combinat = Math::Combinatorics->new(count => scalar(@nums), data => \@nums);
my $max_greatness = 0;
my @permu;
while (@permu = $combinat->next_permutation) {
    $max_greatness = max($max_greatness, calc_greatness(\@nums, \@permu));
}
say $max_greatness;

sub calc_greatness {
    my($nums, $permu) = @_;
    my $greatness = 0;
    for my $i (0 .. $#$nums) {
        $greatness++ if $nums->[$i] < $permu->[$i];
    }
    return $greatness;
}
