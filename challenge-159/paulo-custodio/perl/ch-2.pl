#!/usr/bin/env perl

# Challenge 159
#
# TASK #2 › Moebius Number
# Submitted by: Mohammad S Anwar
# You are given a positive number $n.
#
# Write a script to generate the Moebius Number for the given number.
# Please refer to wikipedia page for more informations.
#
# Example 1:
# Input: $n = 5
# Output: -1
# Example 2:
# Input: $n = 10
# Output: 1
# Example 3:
# Input: $n = 20
# Output: 0

use Modern::Perl;
use ntheory qw( moebius );

my $n = shift || 1;
say moebius($n);
