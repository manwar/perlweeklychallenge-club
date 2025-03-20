#!/bin/env perl

# Challenge 308
#
# Task 2: Decode XOR
# Submitted by: Mohammad Sajid Anwar
#
# You are given an encoded array and an initial integer.
#
# Write a script to find the original array that produced the given encoded
# array. It was encoded such that encoded[i] = orig[i] XOR orig[i + 1].
# Example 1
#
# Input: @encoded = (1, 2, 3), $initial = 1
# Output: (1, 0, 2, 1)
#
# Encoded array created like below, if the original array was (1, 0, 2, 1)
# $encoded[0] = (1 xor 0) = 1
# $encoded[1] = (0 xor 2) = 2
# $encoded[2] = (2 xor 1) = 3
#
# Example 2
#
# Input: @encoded = (6, 2, 7, 3), $initial = 4
# Output: (4, 2, 0, 7, 4)

use Modern::Perl;

my($encoded, $initial) = split(/,/, "@ARGV");
my @encoded = map {$_+0} split ' ', $encoded;   # convert to number
$initial += 0;                                  # convert to number

my @decoded = ($initial);
for (@encoded) {
    push @decoded, $decoded[-1] ^ $_;
}

say "(", join(", ", @decoded), ")";
