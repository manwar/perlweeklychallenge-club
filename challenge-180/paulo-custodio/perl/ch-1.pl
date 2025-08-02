#!/usr/bin/env perl

# Challenge 180
#
# Task 1: First Unique Character
# Submitted by: Mohammad S Anwar
#
# You are given a string, $s.
#
# Write a script to find out the first unique character in the given string and
# print its index (0-based).
# Example 1
#
# Input: $s = "Perl Weekly Challenge"
# Output: 0 as 'P' is the first unique character
#
# Example 2
#
# Input: $s = "Long Live Perl"
# Output: 1 as 'o' is the first unique character

use Modern::Perl;

my @chars = split //, "@ARGV";
my %count; $count{$_}++ for @chars;
my $pos = (map {$_->[0]} grep {$_->[1] == 1} map {[$_, $count{$chars[$_]}]}
           0..$#chars)[0];
say $pos;
