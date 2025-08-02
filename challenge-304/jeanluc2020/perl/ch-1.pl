#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-304/#TASK1
#
# Task 1: Arrange Binary
# ======================
#
# You are given a list of binary digits (0 and 1) and a positive integer, $n.
#
# Write a script to return true if you can re-arrange the list by replacing at
# least $n digits with 1 in the given list so that no two consecutive digits
# are 1 otherwise return false.
#
## Example 1
##
## Input: @digits = (1, 0, 0, 0, 1), $n = 1
## Output: true
##
## Re-arranged list: (1, 0, 1, 0, 1)
#
## Example 2
##
## Input: @digits = (1, 0, 0, 0, 1), $n = 2
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# We can simply turn the list of binary digits into a string.
# Then we can:
# - change 00 at the beginning of the string into 10
# - change 00 at the end of the string into 01
# - change the first 000 into 010
# If none of these replacements is possible, but we still have more
# digits to change from 0 into 1, then we can't change any 0 into 1
# without having at least two 1's in a row.

use strict;
use warnings;

arrange_binary(1, 1, 0, 0, 0, 1);
arrange_binary(2, 1, 0, 0, 0, 1);

sub arrange_binary {
   my ($n, @digits) = @_;
   my $str = join("",@digits);
   while($n >= 1) {
      $str =~ s/^00/^10/ and $n-- and next;
      $str =~ s/00$/01/ and $n-- and next;
      $str =~ s/000/010/ and $n-- and next;
      return print "Output: false\n";
   }
   print "Output: true\n";
}
