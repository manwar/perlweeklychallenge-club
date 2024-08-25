#!/usr/bin/env perl

# Challenge 255
#
# Task 1: Odd Character
# Submitted by: Mohammad Sajid Anwar
# You are given two strings, $s and $t. The string $t is generated using the
# shuffled characters of the string $s with an additional character.
#
# Write a script to find the additional character in the string $t..
#
# Example 1
# Input: $s = "Perl" $t = "Preel"
# Output: "e"
# Example 2
# Input: $s = "Weekly" $t = "Weeakly"
# Output: "a"
# Example 3
# Input: $s = "Box" $t = "Boxy"
# Output: "y"

use Modern::Perl;

my($word, $shuffled) = @ARGV;
for my $ch (split //, $word) {
    $shuffled =~ s/$ch//i;
}
say $shuffled;
