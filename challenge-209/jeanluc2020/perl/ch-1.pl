#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-209/#TASK1
#
# Task 1: Special Bit Characters
# ==============================
#
# You are given an array of binary bits that ends with 0.
#
# Valid sequences in the bit string are:
#
## [0] -decodes-to-> "a"
## [1, 0] -> "b"
## [1, 1] -> "c"
#
# Write a script to print 1 if the last character is an “a” otherwise print 0.
#
## Example 1
##
## Input: @bits = (1, 0, 0)
## Output: 1
##
## The given array bits can be decoded as 2-bits character (10) followed by
#1-bit character (0).
#
## Example 2
##
## Input: @bits = (1, 1, 1, 0)
## Output: 0
##
## Possible decode can be 2-bits character (11) followed by 2-bits character
#(10) i.e. the last character is not 1-bit character.
#
############################################################
##
## discussion
##
############################################################
#
# We walk the array from start to end. If the current element is 1, we
# also take the next one, decode into the character and go on. If the
# last character we found was an "a", we return 1, otherwise 0.

use strict;
use warnings;

special_bit_characters(1, 0, 0);
special_bit_characters(1, 1, 1, 0);

sub special_bit_characters {
   my @bits = @_;
   print "Input: (" . join(", ", @bits) . ")\n";
   # the state we have consist of the last bit (either set to 1  or
   # undef) and the current character (undef or one of a, b, c)
   my $last_bit = undef;
   my $char = undef;
   foreach my $bit (@bits) {
      # if the last bit was set, we either have a b or a c
      if($last_bit) {
         if($bit) {
            $char = "c";
         } else {
            $char = "b";
         }
         # make sure we reset the state of the last bit so we're ready
         # to read the next bit
         $last_bit = undef;
      } else {
         # last bit was not set, so either we start a new 2-bits character
         # or we have the 1-bit character "a"
         if($bit) {
            $last_bit = 1;
            $char = undef;
         } else {
            $char = "a";
         }
      }
   }
   # Now we just need to check whether the last character was the 1-bit
   # character "a" or not
   if($char eq "a") {
      print "Output: 1\n";
      return 1;
   } else {
      print "Output: 0\n";
      return 0;
   }
}
