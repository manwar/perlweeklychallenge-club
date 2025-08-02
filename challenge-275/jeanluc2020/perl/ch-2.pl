#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-275/#TASK2
#
# Task 2: Replace Digits
# ======================
#
# You are given an alphanumeric string, $str, where each character is either a
# letter or a digit.
#
# Write a script to replace each digit in the given string with the value of
# the previous letter plus (digit) places.
#
## Example 1
##
## Input: $str = 'a1c1e1'
## Ouput: 'abcdef'
##
## shift('a', 1) => 'b'
## shift('c', 1) => 'd'
## shift('e', 1) => 'f'
#
## Example 2
##
## Input: $str = 'a1b2c3d4'
## Output: 'abbdcfdh'
##
## shift('a', 1) => 'b'
## shift('b', 2) => 'd'
## shift('c', 3) => 'f'
## shift('d', 4) => 'h'
#
## Example 3
##
## Input: $str = 'b2b'
## Output: 'bdb'
#
## Example 4
##
## Input: $str = 'a16z'
## Output: 'abgz'
#
############################################################
##
## discussion
##
############################################################
#
# Walk the $str character by character. If it is a digits,
# calculate the corresponding new character for the result by
# using the previous character and the digit, otherwise just
# append the current character and take note of the character
# for the next round.

use strict;
use warnings;

replace_digits('a1c1e1');
replace_digits('a1b2c3d4');
replace_digits('b2b');
replace_digits('a16z');

sub replace_digits {
   my $str = shift;
   print "Input: '$str'\n";
   my $previous_char = "a";
   my $result = "";
   foreach my $char (split //, $str) {
      if($char =~ m/\d/) {
         $result .= chr(ord($previous_char) + $char);
      } else {
         $result .= $char;
         $previous_char = $char;
      }
   }
   print "Output: '$result'\n";
}
