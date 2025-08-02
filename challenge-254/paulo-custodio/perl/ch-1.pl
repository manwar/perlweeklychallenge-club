#!/usr/bin/env perl

# Challenge 254
#
# Task 1: Three Power
# Submitted by: Mohammad S Anwar
# You are given a positive integer, $n.
#
# Write a script to return true if the given integer is a power of three
# otherwise return false.
#
# Example 1
# Input: $n = 27
# Output: true
#
# 27 = 3 ^ 3
# Example 2
# Input: $n = 0
# Output: true
#
# 0 = 0 ^ 3
# Example 3
# Input: $n = 6
# Output: false

use Modern::Perl;

my $n = shift || 0;
my $root = $n ** (1/3);
my $have_root = (int($root) == $root);
say $have_root ? 'true' : 'false';
