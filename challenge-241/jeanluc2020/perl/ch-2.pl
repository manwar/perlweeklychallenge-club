#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-241/#TASK2
#
# Task 2: Prime Order
# ===================
#
# You are given an array of unique positive integers greater than 2.
#
# Write a script to sort them in ascending order of the count of their prime
# factors, tie-breaking by ascending value.
#
## Example 1
##
## Input: @int = (11, 8, 27, 4)
## Output: (11, 4, 8, 27))
##
## Prime factors of 11 => 11
## Prime factors of  4 => 2, 2
## Prime factors of  8 => 2, 2, 2
## Prime factors of 27 => 3, 3, 3
#
############################################################
##
## discussion
##
############################################################
#
# Sort by number of prime factors first, then by the number
# itself second.
# We calculate the number of prime factors in an extra recursive
# function, using a cache of already calculated numbers to mitigate
# unnecessary recalculations
#
use strict;
use warnings;

prime_order(11, 8, 27, 4);

sub prime_order {
   my @int = @_;
   print "Input: (" . join(", ", @int) . ")\n";
   my @result = sort { prime_factor_count($a) <=> prime_factor_count($b) || $a <=> $b } @int;
   print "Output: (" . join(", ", @result) . ")\n";
}

{
   my $cache = {};
   sub prime_factor_count {
      my $number = shift;
      my $count = 0;
      unless($cache->{$number}) {
         foreach my $i (2..$number) {
            if($number % $i == 0) {
               $count = 1 + prime_factor_count($number / $i);
               last;
            }
         }
         $cache->{$number} = $count;
      }

      return $cache->{$number};
   }
}
