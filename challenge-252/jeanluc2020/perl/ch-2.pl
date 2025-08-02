#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-252/#TASK2
#
# Task 2: Unique Sum Zero
# =======================
#
# You are given an integer, $n.
#
# Write a script to find an array containing $n unique integers such that they
# add up to zero.
#
## Example 1
##
## Input: $n = 5
## Output: (-7, -1, 1, 3, 4)
##
## Two other possible solutions could be as below:
## (-5, -1, 1, 2, 3) and (-3, -1, 2, -2, 4).
#
## Example 2
##
## Input: $n = 3
## Output: (-1, 0, 1)
#
## Example 3
##
## Input: $n = 1
## Output: (0)
#
############################################################
##
## discussion
##
############################################################
#
# Since we only need to find one array with unique integers, we can
# simply use one with both i and -i in it, with |i| growing, starting
# at 1. In case of an odd number we just add 0 to the array.
use strict;
use warnings;

unique_sum_zero(5);
unique_sum_zero(3);
unique_sum_zero(1);
unique_sum_zero(2);
unique_sum_zero(4);
unique_sum_zero(0);

sub unique_sum_zero {
   my $n = shift;
   print "Input: $n\n";
   my @result = ();
   return print "Output: ()\n" if $n == 0;
   if($n % 2 == 0) {
      # We always use i and -i, ending up at a sum of 0.
      my $val = $n / 2;
      push @result, (-$val..-1);
      push @result, (1..$val);
   } else {
      # We always use i and -i, ending up at a sum of 0 if we add 0.
      my $val = int($n / 2);
      push @result, (-$val..-1);
      push @result, 0;
      push @result, (1..$val);
   }
   print "Output: (", join(", ", @result), ")\n";
}

