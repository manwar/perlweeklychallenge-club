#!/usr/bin/env perl

# Challenge 279
#
# Task 2: Split String
# Submitted by: Mohammad Sajid Anwar
#
# You are given a string, $str.
#
# Write a script to split the given string into two containing exactly same
# number of vowels and return true if you can otherwise false.
#
# Example 1
#
# Input: $str = "perl"
# Ouput: false
#
# Example 2
#
# Input: $str = "book"
# Ouput: true
#
# Two possible strings "bo" and "ok" containing exactly one vowel each.
#
# Example 3
#
# Input: $str = "good morning"
# Ouput: true
#
# Two possible strings "good " and "morning" containing two vowels each or
# "good m" and "orning" containing two vowels each.

use Modern::Perl;

my $str = "@ARGV";
my $vowels = $str =~ tr/aeiouAEIOU/aeiouAEIOU/;
say $vowels % 2 == 0 ? "true" : "false";    # actual splitting is not necessary
