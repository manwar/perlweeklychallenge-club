#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-256/#TASK1
#
# Task 1: Maximum Pairs
# =====================
#
# You are given an array of distinct words, @words.
#
# Write a script to find the maximum pairs in the given array. The words
# $words[i] and $words[j] can be a pair one is reverse of the other.
#
## Example 1
##
## Input: @words = ("ab", "de", "ed", "bc")
## Output: 1
##
## There is one pair in the given array: "de" and "ed"
#
## Example 2
##
## Input: @words = ("aa", "ba", "cd", "ed")
## Output: 0
#
## Example 3
##
## Input: @words = ("uv", "qp", "st", "vu", "mn", "pq")
## Output: 2
#
############################################################
##
## discussion
##
############################################################
#
# Just check all possible pairs.

use strict;
use warnings;

maximum_pairs("ab", "de", "ed", "bc");
maximum_pairs("aa", "ba", "cd", "ed");
maximum_pairs("uv", "qp", "st", "vu", "mn", "pq");

sub maximum_pairs {
   my @words = @_;
   print "Input: (\"" . join("\", \"", @words) . "\")\n";
   my $count = 0;
   foreach my $i (0..$#words) {
      foreach my $j ($i+1..$#words) {
         if($words[$i] eq reversed($words[$j]) ) {
            $count++;
            last;
         }
      }
   }
   print "Output: $count\n";
}

sub reversed {
   my $word = shift;
   return join("", reverse split //, $word);
}
