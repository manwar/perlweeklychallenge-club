#!/usr/bin/env perl

# Challenge 281
#
# Task 1: Check Color
# Submitted by: Mohammad Sajid Anwar
#
# You are given coordinates, a string that represents the coordinates of a
# square of the chessboard as shown below:
#
# Write a script to return true if the square is light, and false if the square
# is dark.
#
# Example 1
#
# Input: $coordinates = "d3"
# Output: true
#
# Example 2
#
# Input: $coordinates = "g5"
# Output: false
#
# Example 3
#
# Input: $coordinates = "e6"
# Output: true

use Modern::Perl;

@ARGV==1 or die "Usage: $0 coordinates\n";
(my $coords = shift) =~ /^[a-h][1-8]$/ or die "Usage: $0 coordinates\n";

my @coords = split //, $coords;
my $light = (((ord($coords[0])-ord('a'))) & 1) ^ (($coords[1]-1) & 1);
say $light ? "true" : "false";
