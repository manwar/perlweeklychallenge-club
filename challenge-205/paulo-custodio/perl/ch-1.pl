#!/usr/bin/perl

# Challenge 205
#
# Task 1: Third Highest
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to find out the Third Highest if found otherwise return the maximum.
# Example 1
#
# Input: @array = (5,3,4)
# Output: 3
#
# First highest is 5. Second highest is 4. Third highest is 3.
#
# Example 2
#
# Input: @array = (5,6)
# Output: 6
#
# First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.
#
# Example 3
#
# Input: @array = (5,4,4,3)
# Output: 3
#
# First highest is 5. Second highest is 4. Third highest is 3.

use Modern::Perl;
my %in; $in{$_}++ for @ARGV;
my @in = reverse sort {$a<=>$b} keys %in;
if (!@in) {
    say 0;
}
elsif (@in < 3) {
    say $in[0];
}
else {
    say $in[2];
}
