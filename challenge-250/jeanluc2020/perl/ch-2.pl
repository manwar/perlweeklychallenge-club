#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-250/#TASK2
#
# Task 2: Alphanumeric String Value
# =================================
#
# You are given an array of alphanumeric strings.
#
# Write a script to return the maximum value of alphanumeric string in the
# given array.
#
# The value of alphanumeric string can be defined as
#
# a) The numeric representation of the string in base 10 if it is made up of
#    digits only.
# b) otherwise the length of the string
#
#
## Example 1
##
## Input: @alphanumstr = ("perl", "2", "000", "python", "r4ku")
## Output: 6
##
## "perl" consists of letters only so the value is 4.
## "2" is digits only so the value is 2.
## "000" is digits only so the value is 0.
## "python" consits of letters so the value is 6.
## "r4ku" consists of letters and digits so the value is 4.
#
## Example 2
##
## Input: @alphanumstr = ("001", "1", "000", "0001")
## Output: 1
#
############################################################
##
## discussion
##
############################################################
#
# Try to match each string against a non-digit character. If that succeeds (or
# the length is 0), use the length. If it doesn't, convert the string to an
# integer.

use strict;
use warnings;

alphanumeric_string_value("perl", "2", "000", "python", "r4ku");
alphanumeric_string_value("001", "1", "000", "0001");

sub alphanumeric_string_value {
   my @alphanumstr = @_;
   print "Input: (" . join(", ", @alphanumstr) . ")\n";
   my $max = 0;
   foreach my $string (@alphanumstr) {
      # We skip the case where length($string) == 0, as that's the
      # default for $max anyway
      if(length($string) != 0) {
         if($string =~ m/[^\d]/) {
            $max = length($string) if length($string) > $max;
         } else {
            $max = int($string) if int($string) > $max;
         }
      }
   }
   print "Output: $max\n";
}
