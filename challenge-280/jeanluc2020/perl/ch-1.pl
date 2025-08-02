#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-280/#TASK1
#
# Task 1: Twice Appearance
# ========================
#
# You are given a string, $str, containing lowercase English letters only.
#
# Write a script to print the first letter that appears twice.
#
## Example 1
##
## Input: $str = "acbddbca"
## Output: "d"
#
## Example 2
##
## Input: $str = "abccd"
## Output: "c"
#
## Example 3
##
## Input: $str = "abcdabbb"
## Output: "a"
#
############################################################
##
## discussion
##
############################################################
#
# Read one character at a time, and return it if it was already
# in the string before.

use strict;
use warnings;

twice_appearance("acbddbca");
twice_appearance("abccd");
twice_appearance("abcdabbb");

sub twice_appearance {
   my $str = shift;
   my $seen = {};
   print "Input: \"$str\"\n";
   foreach my $char (split //, $str) {
      return print "Output: $char\n" if $seen->{$char};
      $seen->{$char} = 1;
   }
   print "Output: None\n";
}
