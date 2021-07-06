#!/usr/bin/env perl

# Challenge 120
#
# TASK #1 - Swap Odd/Even bits
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N less than or equal to 255.
#
# Write a script to swap the odd positioned bit with even positioned bit and
# print the decimal equivalent of the new binary representation.
#
# Example
# Input: $N = 101
# Output: 154
#
# Binary representation of the given number is 01 10 01 01.
# The new binary representation after the odd/even swap is 10 01 10 10.
# The decimal equivalent of 10011010 is 154.
#
# Input: $N = 18
# Output: 33
#
# Binary representation of the given number is 00 01 00 10.
# The new binary representation after the odd/even swap is 00 10 00 01.
# The decimal equivalent of 100001 is 33.

use Modern::Perl;

my $n = shift || 0;
say swap_bits($n);

sub swap_bits {
    my($n) = @_;
    my $out = 0;
    my $shift = 0;
    while ($n > 0) {
        if (($n & 1) != 0) { $out |= 2 << $shift; }
        if (($n & 2) != 0) { $out |= 1 << $shift; }
        $n >>= 2;
        $shift += 2;
    }
    return $out;
}
