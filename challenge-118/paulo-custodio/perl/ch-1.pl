#!/usr/bin/env perl

# Challenge 118
#
# TASK #1 - Binary Palindrome
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
#
# Write a script to find out if the binary representation of the given integer
# is Palindrome. Print 1 if it is otherwise 0.
#
# Example
# Input: $N = 5
# Output: 1 as binary representation of 5 is 101 which is Palindrome.
#
# Input: $N = 4
# Output: 0 as binary representation of 4 is 100 which is NOT Palindrome.

use Modern::Perl;

my $N = shift // 0;
my $bits = sprintf("%b", $N);
my $rbits = reverse($bits);
say $bits eq $rbits ? 1 : 0;
