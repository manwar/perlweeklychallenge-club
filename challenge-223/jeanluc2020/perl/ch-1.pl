#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-223/#TASK1
#
# Task 1: Count Primes
# ====================
#
# You are given a positive integer, $n.
#
# Write a script to find the total count of primes less than or equal to the given integer.
#
## Example 1
##
## Input: $n = 10
## Output: 4
##
## Since there are 4 primes (2,3,5,7) less than or equal to 10.
#
## Example 2
##
## Input: $n = 1
## Output: 0
#
## Example 3
##
## Input: $n = 20
## Output: 8
##
## Since there are 4 primes (2,3,5,7,11,13,17,19) less than or equal to 20.
#
############################################################
##
## discussion
##
############################################################
#
# Counting from 1 upward, we check each number whether it is a prime
# If it is, we increment a counter
# In order to not recalculate the same thing over and over again, we keep
# a cache for numbers already checked for being prime.

use strict;
use warnings;

count_primes(10);
count_primes(1);
count_primes(20);
count_primes(100);
count_primes(1000);
count_primes(10000);

sub count_primes {
   my $max = shift;
   my $primes = 0;
   foreach my $num (1..$max) {
      $primes += is_prime($num);
   }
   print "Input: $max\nOutput: $primes\n";
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
