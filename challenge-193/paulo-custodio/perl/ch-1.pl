#!/usr/bin/perl

# Challenge 193
#
# Task 1: Binary String
# Submitted by: Mohammad S Anwar
# You are given an integer, $n > 0.
#
# Write a script to find all possible binary numbers of size $n.
#
# Example 1
# Input: $n = 2
# Output: 00, 11, 01, 10
# Example 2
# Input: $n = 3
# Output: 000, 001, 010, 100, 111, 110, 101, 011

use Modern::Perl;

@ARGV==1 or die "usage: ch-1.pl n\n";
my $n=shift||1;
say join ", ", map{sprintf("%0${n}b", $_)} (0..2**$n-1);

