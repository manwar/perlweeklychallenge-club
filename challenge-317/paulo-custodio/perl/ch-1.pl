#!/usr/bin/env perl

# Challenge 317
#
# Task 1: Acronyms
# Submitted by: Mohammad Sajid Anwar
# You are given an array of words and a word.
#
# Write a script to return true if concatenating the first letter of each word in the given array matches the given word, return false otherwise.
#
#
# Example 1
# Input: @array = ("Perl", "Weekly", "Challenge")
#        $word  = "PWC"
# Output: true
#
# Example 2
# Input: @array = ("Bob", "Charlie", "Joe")
#        $word  = "BCJ"
# Output: true
#
# Example 3
# Input: @array = ("Morning", "Good")
#        $word  = "MM"
# Output: false

use Modern::Perl;

my @words = split ' ', <>;
chomp(my $word = <>);
my $acronym = join '', map {substr($_,0,1)} @words;
say $word eq $acronym ? "true" : "false";
