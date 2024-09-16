#!/usr/bin/env perl

# Challenge 254
#
# Task 2: Reverse Vowels
# Submitted by: Mohammad S Anwar
# You are given a string, $s.
#
# Write a script to reverse all the vowels (a, e, i, o, u) in the given string.
#
# Example 1
# Input: $s = "Raku"
# Output: "Ruka"
# Example 2
# Input: $s = "Perl"
# Output: "Perl"
# Example 3
# Input: $s = "Julia"
# Output: "Jaliu"
# Example 4
# Input: $s = "Uiua"
# Output: "Auiu"

use Modern::Perl;

my $word = shift || "";
my @vowels;
$word =~ s/[aeiou]/ push @vowels, $&; $& /gei;
$word =~ s/[aeiou]/ pop @vowels /gei;
$word =~ s/(.)(.*)/ uc($1).lc($2) /e;
say $word;
