#!/usr/bin/env perl

# Challenge 252
#
# Task 2: Unique Sum Zero
# Submitted by: Mohammad S Anwar
#
# You are given an integer, $n.
#
# Write a script to find an array containing $n unique integers such that they add up to zero.
# Example 1
#
# Input: $n = 5
# Output: (-7, -1, 1, 3, 4)
#
# Two other possible solutions could be as below:
# (-5, -1, 1, 2, 3) and (-3, -1, 2, -2, 4).
#
# Example 2
#
# Input: $n = 3
# Output: (-1, 0, 1)
#
# Example 3
#
# Input: $n = 1
# Output: (0)

use Modern::Perl;

my $n = shift || 0;
die "Usage: ch-2.pl N\n" if $n < 1;

my @half = 1..int($n/2);
my @out = ((reverse map {-$_} @half), (($n % 2 == 1) ? (0) : ()), (@half));
say "(", join(", ", @out), ")";
