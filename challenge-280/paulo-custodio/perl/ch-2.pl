#!/usr/bin/env perl

# Challenge 280
#
# Task 2: Count Asterisks
# Submitted by: Mohammad Sajid Anwar
# You are given a string, $str, where every two consecutive vertical bars are
# grouped into a pair.
#
# Write a script to return the number of asterisks, *, excluding any between
# each pair of vertical bars.
#
# Example 1
# Input: $str = "p|*e*rl|w**e|*ekly|"
# Ouput: 2
#
# The characters we are looking here are "p" and "w**e".
# Example 2
# Input: $str = "perl"
# Ouput: 0
# Example 3
# Input: $str = "th|ewe|e**|k|l***ych|alleng|e"
# Ouput: 5
#
# The characters we are looking here are "th", "e**", "l***ych" and "e".

use Modern::Perl;

my $str = shift // "";
$str =~ s/\|[^|]*\|//g;
my $count = $str =~ tr/*/*/;
say $count;
