#!/usr/bin/perl

# Challenge 202
#
# Task 1: Consecutive Odds
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to print 1 if there are THREE consecutive odds in the given array
# otherwise print 0.
#
# Example 1
#
# Input: @array = (1,5,3,6)
# Output: 1
#
# Example 2
#
# Input: @array = (2,6,3,5)
# Output: 0
#
# Example 3
#
# Input: @array = (1,2,3,4)
# Output: 0
#
# Example 4
#
# Input: @array = (2,3,5,7)
# Output: 1

use Modern::Perl;
my @in = @ARGV;
my $s = join('', map {($_%2)==0 ? "0" : "1"} @in);
say $s =~ /111/ ? 1 : 0;
