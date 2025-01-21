#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-305/#TASK1
#
# Task 1: Binary Prefix
# =====================
#
# You are given a binary array.
#
# Write a script to return an array of booleans where the partial binary number
# up to that point is prime.
#
## Example 1
##
## Input: @binary = (1, 0, 1)
## Output: (false, true, true)
##
## Sub-arrays (base-10):
## (1): 1 - not prime
## (1, 0): 2 - prime
## (1, 0, 1): 5 - prime
#
## Example 2
##
## Input: @binary = (1, 1, 0)
## Output: (false, true, false)
##
## Sub-arrays (base-10):
## (1): 1 - not prime
## (1, 1): 3 - prime
## (1, 1, 0): 6 - not prime
#
## Example 3
##
## Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
## Output: (false, true, true, false, false, true, false, false, false, false,
## false, false, false, false, false, false, false, false, false, true)
#
############################################################
##
## discussion
##
############################################################
#
# We can initialize $num as 0. Appending another binary digit is the same
# as multiplying $num by two, then adding the next digit. So we can go
# digit by digit, calculating the new number in each step and checking whether
# or not it is prime. Then we just need to print the result.
# Note: I used the is_prime() function from my solution to challenge 233.

use strict;
use warnings;

binary_prefix(1, 0, 1);
binary_prefix(1, 1, 0);
binary_prefix(1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1);

sub binary_prefix {
   my @binary = @_;
   print "Input: (" . join(", ", @binary) . ")\n";
   my @result = ();
   my $num = 0;
   foreach my $digit (@binary) {
      $num *= 2;
      $num += $digit;
      push @result, is_prime($num) ? "true" : "false";
   }
   print "Output: (" . join(", ", @result) . ")\n";
}


{
   my $cache;
   sub is_prime {
      my $num = shift;
      return 0 if $num == 1;
      return $cache->{$num} if defined $cache->{$num};
      my $divider = 2;
      while($divider <= sqrt($num)) {
         if(int($num/$divider) == $num/$divider) {
            $cache->{$num} = 0;
            return 0;
         }
         $divider++;
      }
      $cache->{$num} = 1;
      return 1;
   }
}

