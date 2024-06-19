#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-273/#TASK2
#
# Task 2: B After A
# =================
#
# You are given a string, $str.
#
# Write a script to return true if there is at least one b, and no a appears
# after the first b.
#
## Example 1
##
## Input: $str = "aabb"
## Output: true
#
## Example 2
##
## Input: $str = "abab"
## Output: false
#
## Example 3
##
## Input: $str = "aaa"
## Output: false
#
## Example 4
##
## Input: $str = "bbb"
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# We walk the string character for character. If we find a "b"
# we remember this fact. If we encounter an "a" and have already
# seen a "b", we return false. If we're at the end of the string
# our output depends on whether or not we have seen a "b": we
# didn't bail out for seeing an "a" after a "b", so if we didn't
# see any "b" at all, we return false, otherwise true.

use strict;
use warnings;

b_after_a("aabb");
b_after_a("abab");
b_after_a("aaa");
b_after_a("bbb");

sub b_after_a {
   my $str = shift;
   print "Input: '$str'\n";
   my $b_seen = 0;
   foreach my $char (split //, $str) {
      $b_seen = 1 if $char eq "b";
      if($b_seen) {
         return print "Output: false\n" if $char eq "a";
      }
   }
   if($b_seen) {
      print "Output: true\n";
   } else {
      print "Output: false\n";
   }
}
