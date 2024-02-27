#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/#TASK1
#
# Task 1: Count Even Digits Number
# ================================
#
# You are given a array of positive integers, @ints.
#
# Write a script to find out how many integers have even number of digits.
#
## Example 1
##
## Input: @ints = (10, 1, 111, 24, 1000)
## Output: 3
##
## There are 3 integers having even digits i.e. 10, 24 and 1000.
#
## Example 2
##
## Input: @ints = (111, 1, 11111)
## Output: 0
#
## Example 3
##
## Input: @ints = (2, 8, 1024, 256)
## Output: 1
#
############################################################
##
## discussion
##
############################################################
#
# Just calculate the length of each integer an check if it is
# even, then in the end tell how many those were.

use strict;
use warnings;

count_even_digits_number(10, 1, 111, 24, 1000);
count_even_digits_number(111, 1, 11111);
count_even_digits_number(2, 8, 1024, 256);

sub count_even_digits_number {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $result = 0;
   foreach my $number (@ints) {
      if(length($number) % 2 == 0) {
         $result++;
      }
   }
   print "Output: $result\n";
}


