#!/usr/bin/env perl

# Challenge 253
#
# Task 1: Split Strings
# Submitted by: Mohammad S Anwar
# You are given an array of strings and a character separator.
#
# Write a script to return all words separated by the given character
# excluding empty string.
#
# Example 1
# Input: @words = ("one.two.three","four.five","six")
#        $separator = "."
# Output: "one","two","three","four","five","six"
# Example 2
# Input: @words = ("$perl$$", "$$raku$")
#        $separator = "$"
# Output: "perl","raku"

use Modern::Perl;

my($sep, @words) = @ARGV;
my $words = join($sep, @words);
@words = grep {$_ ne ''} split /\Q$sep/, $words;
say "@words";
