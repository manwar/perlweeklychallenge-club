#!/usr/bin/perl

# Challenge 095
#
# TASK #1 › Palindrome Number
# Submitted by: Mohammad S Anwar
# You are given a number $N.
#
# Write a script to figure out if the given number is Palindrome. Print 1 if true otherwise 0.
#
# Example 1:
# Input: 1221
# Output: 1
# Example 2:
# Input: -101
# Output: 0, since -101 and 101- are not the same.
# Example 3:
# Input: 90
# Output: 0

use strict;
use warnings;
use 5.030;

my $N = shift;
say join('', reverse split(//, $N)) eq $N ? 1 : 0;
