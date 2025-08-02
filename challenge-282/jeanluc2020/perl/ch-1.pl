#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/#TASK1
#
# Task 1: Good Integer
# ====================
#
# You are given a positive integer, $int, having 3 or more digits.
#
# Write a script to return the Good Integer in the given integer or -1 if none found.
#
### A good integer is exactly three consecutive matching digits.
#
## Example 1
##
## Input: $int = 12344456
## Output: "444"
#
## Example 2
##
## Input: $int = 1233334
## Output: -1
#
## Example 3
##
## Input: $int = 10020003
## Output: "000"
#
############################################################
##
## discussion
##
############################################################
#
# We just walk the digits, taking note of the previous digit
# and how often it occured already. If the current digit is
# different from the previous one and we have seen the
# previous digit exactly 3 times, we return that digit
# 3 times. If we reached the end of $int, we just have to check
# whether the last digit was seen 3 times as well.

use strict;
use warnings;

good_integer(12344456);
good_integer(1233334);
good_integer(10020003);

sub good_integer {
   my $int = shift;
   print "Input: $int\n";
   my $prev_digit = "";
   my $seen = 0;
   foreach my $digit (split //, $int) {
      if($prev_digit eq $digit) {
         $seen++;
      } elsif ($seen == 3) {
         return print "Output: $prev_digit$prev_digit$prev_digit\n";
      } else {
         $prev_digit = $digit;
         $seen = 1;
      }
   }
   if($seen == 3) {
      return print "Output: $prev_digit$prev_digit$prev_digit\n";
   }
   print "Output: -1\n";
}
