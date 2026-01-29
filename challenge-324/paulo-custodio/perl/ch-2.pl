#!/usr/bin/env perl

# Challenge 324
#
# Task 2: Total XOR
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers.
#
# Write a script to return the sum of total XOR for every subset of given array.
#
#
# Example 1
# Input: @ints = (1, 3)
# Output: 6
#
# Subset [1],    total XOR = 1
# Subset [3],    total XOR = 3
# Subset [1, 3], total XOR => 1 XOR 3 => 2
#
# Sum of total XOR => 1 + 3 + 2 => 6
#
# Example 2
# Input: @ints = (5, 1, 6)
# Output: 28
#
# Subset [5],       total XOR = 5
# Subset [1],       total XOR = 1
# Subset [6],       total XOR = 6
# Subset [5, 1],    total XOR => 5 XOR 1 => 4
# Subset [5, 6],    total XOR => 5 XOR 6 => 3
# Subset [1, 6],    total XOR => 1 XOR 6 => 7
# Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2
#
# Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28
#
# Example 3
# Input: @ints = (3, 4, 5, 6, 7, 8)
# Output: 480

use Modern::Perl;

@ARGV or die "usage: $$0 nums...\n";

my @nums = @ARGV;
my @sets = get_power_set(@nums);
my $sum = 0;
for (@sets) {
    $sum += xor_list(@$_);
}
say $sum;

sub get_power_set {
    my ($first, @rest) = @_;
    return ([]) unless defined $first;

    my @without_first = get_power_set(@rest);
    my @with_first    = map { [$first, @$_] } @without_first;

    return (@with_first, @without_first);
}

sub xor_list {
    my(@nums) = @_;
    my $xor = 0;
    for (@nums) {
        $xor ^= $_;
    }
    return $xor;
}
