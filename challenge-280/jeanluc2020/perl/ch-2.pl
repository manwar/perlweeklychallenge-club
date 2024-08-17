#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-280/#TASK2
#
# Task 2: Count Asterisks
# =======================
#
# You are given a string, $str, where every two consecutive vertical bars are
# grouped into a pair.
#
# Write a script to return the number of asterisks, *, excluding any between
# each pair of vertical bars.
#
## Example 1
##
## Input: $str = "p|*e*rl|w**e|*ekly|"
## Ouput: 2
##
## The characters we are looking here are "p" and "w**e".
#
## Example 2
##
## Input: $str = "perl"
## Ouput: 0
#
## Example 3
##
## Input: $str = "th|ewe|e**|k|l***ych|alleng|e"
## Ouput: 5
##
## The characters we are looking here are "th", "e**", "l***ych" and "e".
#
############################################################
##
## discussion
##
############################################################
#
# Split $str at | characters, and then only look at the odd
# ones. Split those into single characters and count the stars.

use strict;
use warnings;

count_asterisks("p|*e*rl|w**e|*ekly|");
count_asterisks("perl");
count_asterisks("th|ewe|e**|k|l***ych|alleng|e");

sub count_asterisks {
   my $str = shift;
   my @parts = split /\|/, $str;
   my $index = 0;
   my $count = 0;
   print "Input: \"$str\"\n";
   foreach my $part (@parts) {
      $index++;
      next unless $index % 2;
      foreach my $char (split //, $part) {
         $count++ if $char eq '*';
      }
   }
   print "Output: $count\n";
}
