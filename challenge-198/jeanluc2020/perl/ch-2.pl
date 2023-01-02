#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-198/#TASK2
#
# You are given an integer $n > 0.
#
# Write a script to print the count of primes less than $n.
#
## Example 1
##
## Input: $n = 10
## Output: 4 as in there are 4 primes less than 10 are 2, 3, 5 ,7.
#
## Example 2
##
## Input: $n = 15
## Output: 6
#
## Example 3
##
## Input: $n = 1
## Output: 0
#
## Example 4
##
## Input: $n = 25
## Output: 9
#
### This is a nice little task, so let's just simply count all the primes
### up to $n-1 (since we want to count primes that are less than $n)
### To do that, just check each of the integers up to $n whether it is
### prime or not and increment a counter if it is

use strict;
use warnings;
use feature 'say';

my @examples = (10, 15, 1, 25, 23, 30, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000);

foreach my $n (@examples) {
   say "There are " . count_primes($n) . " primes < $n";
}

# count all the primes < $n
sub count_primes {
   my $n = shift;
   my $count = 0;
   # since we're only interested in primes less than $n, we only look for
   # primes up to $n-1. Should $n be a prime itself, we don't count it
   foreach my $i (1..$n-1) {
      $count++ if is_prime($i); # increment $count in case we have a prime
   }
   return $count;
}

# helper function to check wether an integer is a prime
sub is_prime {
   my $n = shift;
   return 0 if $n < 2; # 1 isn't prime
   foreach(2..sqrt($n)) {
      # if any integer < sqrt($n) divides $n, we don't have a prime
      return 0 unless $n % $_;
   }
   # since we didn't find any integer that divides $n, we have a prime
   return 1;
}
