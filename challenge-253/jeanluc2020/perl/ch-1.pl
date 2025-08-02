#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-253/#TASK1
#
# Task 1: Split Strings
# =====================
#
# You are given an array of strings and a character separator.
#
# Write a script to return all words separated by the given character excluding
# empty string.
#
# Example 1
#
# Input: @words = ("one.two.three","four.five","six")
#        $separator = "."
# Output: "one","two","three","four","five","six"
#
# Example 2
#
# Input: @words = ("$perl$$", "$$raku$")
#        $separator = "$"
# Output: "perl","raku"
#
############################################################
##
## discussion
##
############################################################
#
# This is a classic one-liner problem: join the words into a single string,
# then split this string into an array of strings at the separator, then
# only keep the non-empty strings by grepping for strings that contain one
# character.
#

use strict;
use warnings;

split_strings(".", "one.two.three","four.five","six");
split_strings('$', '$perl$$', '$$raku$');

sub split_strings {
   my ($separator, @words) = @_;
   print "Input: (\"" . join("\", \"", @words) . "\"), '$separator'\n";
   my @output = grep /./, split /\Q$separator\E/, join($separator, @words);
   print "Output: (\"" . join("\", \"", @output) . "\")\n";
}

