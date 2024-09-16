#!/usr/bin/env perl

# Challenge 226
#
# Task 1: Shuffle String
# Submitted by: Mohammad S Anwar
# You are given a string and an array of indices of same length as string.
#
# Write a script to return the string after re-arranging the indices in the correct order.
#
# Example 1
# Input: $string = 'lacelengh', @indices = (3,2,0,5,4,8,6,7,1)
# Output: 'challenge'
# Example 2
# Input: $string = 'rulepark', @indices = (4,7,3,1,0,5,2,6)
# Output: 'perlraku'

use Modern::Perl;

my($str, @idx) = @ARGV;
my @chars = split //, $str;
say join('', map {$_->[1]} sort {$a->[0] <=> $b->[0]} map {[$idx[$_], $chars[$_]]} 0..$#chars);
