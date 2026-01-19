#!/usr/bin/env perl

# Challenge 344
#
# Task 1: Array Form Compute
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints and an integer, $x.
#
# Write a script to add $x to the integer in the array-form.
#
# The array form of an integer is a digit-by-digit representation stored as an array, where the most significant digit is at the 0th index.
#
#
# Example 1
# Input: @ints = (1, 2, 3, 4), $x = 12
# Output: (1, 2, 4, 6)
#
# Example 2
# Input: @ints = (2, 7, 4), $x = 181
# Output: (4, 5, 5)
#
# Example 3
# Input: @ints = (9, 9, 9), $x = 1
# Output: (1, 0, 0, 0)
#
# Example 4
# Input: @ints = (1, 0, 0, 0, 0), $x = 9999
# Output: (1, 9, 9, 9, 9)
#
# Example 5
# Input: @ints = (0), $x = 1000
# Output: (1, 0, 0, 0)

use Modern::Perl;

@ARGV==2 or die "usage: $0 'nums...' x\n";
my($nums, $x) = @ARGV;
my @nums = split ' ', $nums;
my @x = split //, $x;
my @result = add(\@nums, \@x);
say join ", ", @result;

sub add {
    my($a, $b) = @_;
    my @a = reverse @$a;
    my @b = reverse @$b;
    my @x;
    my $carry = 0;
    for (my $i = 0; $i < @a || $i < @b || $carry != 0; $i++) {
        my $digit = ($a[$i]//0) + ($b[$i]//0) + $carry;
        push @x, $digit % 10;
        $carry = int($digit / 10);
    }
    return reverse @x;
}
