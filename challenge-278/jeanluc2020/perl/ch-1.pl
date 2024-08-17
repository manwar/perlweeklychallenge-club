#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-278/#TASK1
#
# Task 1: Sort String
# ===================
#
# You are given a shuffle string, $str.
#
# Write a script to return the sorted string.
#
### A string is shuffled by appending word position to each word.
#
## Example 1
##
## Input: $str = "and2 Raku3 cousins5 Perl1 are4"
## Output: "Perl and Raku are cousins"
#
## Example 2
##
## Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"
## Output: "Python is the most popular guest language"
#
## Example 3
##
## Input: $str = "Challenge3 The1 Weekly2"
## Output: "The Weekly Challenge"
#
############################################################
##
## discussion
##
############################################################
#
# Split $str into words, then split each word into the word position
# and the actual word. Then sort this list by word position and
# add the words to the result.

use strict;
use warnings;

sort_string("and2 Raku3 cousins5 Perl1 are4");
sort_string("guest6 Python1 most4 the3 popular5 is2 language7");
sort_string("Challenge3 The1 Weekly2");

sub sort_string {
   my $str = shift;
   my @words = split/\s+/, $str;
   my $sorted = {};
   print "Input: \"$str\"\n";
   foreach my $word (@words) {
      $word =~ s/(\d+)$//;
      $sorted->{$1} = $word;
   }
   my $result = "";
   foreach my $number (sort {$a <=> $b} keys %$sorted) {
      $result .= "$sorted->{$number} ";
   }
   $result =~ s/\s+$//;
   print "Output: \"$result\"\n";
}
