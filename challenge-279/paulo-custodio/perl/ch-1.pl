#!/usr/bin/env perl

# Challenge 279
#
# Task 1: Sort Letters
# Submitted by: Mohammad Sajid Anwar
#
# You are given two arrays, @letters and @weights.
#
# Write a script to sort the given array @letters based on the @weights.
# Example 1
#
# Input: @letters = ('R', 'E', 'P', 'L')
#        @weights = (3, 2, 1, 4)
# Output: PERL
#
# Example 2
#
# Input: @letters = ('A', 'U', 'R', 'K')
#        @weights = (2, 4, 1, 3)
# Output: RAKU
#
# Example 3
#
# Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
#        @weights = (5, 4, 2, 6, 1, 3)
# Output: PYTHON

use Modern::Perl;

@ARGV > 2 or die "Usage: $0 LETTTERS WEIGHTS...\n";
my($letters, @weights) = @ARGV;
my @letters = split //, $letters;
say join('',
        map {$_->[0]}
        sort {$a->[1] <=> $b->[1]}
        map {[$letters[$_], $weights[$_]]} 0..$#letters);
