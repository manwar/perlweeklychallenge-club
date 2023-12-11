#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-247/#TASK2
#
# Task 2: Most Frequent Letter Pair
# =================================
#
# You are given a string S of lower case letters 'a'..'z'.
#
# Write a script that finds the pair of consecutive letters in S that appears
# most frequently. If there is more than one such pair, chose the one that is
# the lexicographically first.
#
## Example 1
##
## Input: $s = 'abcdbca'
## Output: 'bc'
##
## 'bc' appears twice in `$s`
#
## Example 2
##
## Input: $s = 'cdeabeabfcdfabgcd'
## Output: 'ab'
##
## 'ab' and 'cd' both appear three times in $s and 'ab' is lexicographically
## smaller than 'cd'.
#
############################################################
##
## discussion
##
############################################################
#
# Create a map with all substrings as keys and their frequency as value,
# then sort by frequency descending and then by key ascending and return
# the first element of the sorted list

use strict;
use warnings;

most_frequent_letter_pair('abcdbca');
most_frequent_letter_pair('cdeabeabfcdfabgcd');

sub most_frequent_letter_pair {
   my $s = shift;
   print "Input: $s\n";
   my @letters = split //, $s;
   my $map = {};
   foreach my $i (0..$#letters-1) {
      my $new = $letters[$i] . $letters[$i+1];
      $map->{$new}++;
   }
   my @sorted = sort { $map->{$b} <=> $map->{$a} || $a cmp $b } keys %$map;
   print "Output: $sorted[0]\n";
}
