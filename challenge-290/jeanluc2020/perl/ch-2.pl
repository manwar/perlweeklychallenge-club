#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-290/#TASK2
#
# Task 2: Luhn’s Algorithm
# ========================
#
# You are given a string $str containing digits (and possibly other characters
# which can be ignored). The last digit is the payload; consider it separately.
# Counting from the right, double the value of the first, third, etc. of the
# remaining digits.
#
# For each value now greater than 9, sum its digits.
#
# The correct check digit is that which, added to the sum of all values, would
# bring the total mod 10 to zero.
#
# Return true if and only if the payload is equal to the correct check digit.
#
# It was originally posted on reddit.
#
## Example 1
##
## Input: "17893729974"
## Output: true
##
## Payload is 4.
##
## Digits from the right:
##
## 7 * 2 = 14, sum = 5
## 9 = 9
## 9 * 2 = 18, sum = 9
## 2 = 2
## 7 * 2 = 14, sum = 5
## 3 = 3
## 9 * 2 = 18, sum = 9
## 8 = 8
## 7 * 2 = 14, sum = 5
## 1 = 1
##
## Sum of all values = 56, so 4 must be added to bring the total mod 10 to
## zero. The payload is indeed 4.
#
## Example 2
##
## Input: "4137 8947 1175 5904"
## Output: true
#
## Example 3
##
## Input: "4137 8974 1175 5904"
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# First, we split the string into its characters, keep only
# the digits and reverse their order. We now put the first
# element into a $payload variable, the rest goes into an
# array @digits. Next, for the odd elements of the array, we
# double the value and sum the digits of that if bigger than 9.
# In the end, we add that to the sum so far. We then calculate
# the sum mod 10, substract that from 10 to find the correct
# payload. If the payload matches that, we return True, otherwise
# False.

use strict;
use warnings;

luhns_algorithm("17893729974");
luhns_algorithm("4137 8947 1175 5904");
luhns_algorithm("4137 8974 1175 5904");

sub luhns_algorithm {
   my $str = shift;
   print "Input: $str\n";
   my ($payload, @digits) = reverse grep { /[0-9]/ } split //, $str;
   my $odd = 1;
   my $sum = 0;
   foreach my $digit (@digits) {
      if($odd) {
         $digit *= 2;
         if($digit > 9) {
            my ($first, $second) = split //, $digit;
            $digit = $first + $second;
         }
         $odd = 0;
      } else {
         $odd = 1;
      }
      $sum += $digit;
   }
   my $mod = $sum % 10;
   my $correct = 10 - $mod;
   if($payload == $correct) {
      print "Output: True\n";
   } else {
      print "Output: False\n";
   }
}
