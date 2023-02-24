#!/usr/bin/perl

# Challenge 205
#
# Task 2: Maximum XOR
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to find the highest value obtained by XORing any two distinct members of the array.
# Example 1
#
# Input: @array = (1,2,3,4,5,6,7)
# Output: 7
#
# The maximum result of 1 xor 6 = 7.
#
# Example 2
#
# Input: @array = (2,4,1,3)
# Output: 7
#
# The maximum result of 4 xor 3 = 7.
#
# Example 3
#
# Input: @array = (10,5,7,12,8)
# Output: 15
#
# The maximum result of 10 xor 5 = 15.

use Modern::Perl;
my @in = @ARGV;
my $max = -1;
for my $i (0..$#in-1) {
    for my $j ($i+1..$#in) {
        my $n = ord(chr($in[$i]) ^ chr($in[$j]));
        $max=$n if $max<$n;
    }
}
say $max;
