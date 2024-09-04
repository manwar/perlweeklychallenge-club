#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-285/#TASK2
#
# Task 2: Making Change
# =====================
#
# Compute the number of ways to make change for given amount in cents. By using
# the coins e.g. Penny, Nickel, Dime, Quarter and Half-dollar, in how many
# distinct ways can the total value equal to the given amount? Order of coin
# selection does not matter.
#
# A penny (P) is equal to 1 cent.
# A nickel (N) is equal to 5 cents.
# A dime (D) is equal to 10 cents.
# A quarter (Q) is equal to 25 cents.
# A half-dollar (HD) is equal to 50 cents.
#
## Example 1
##
## Input: $amount = 9
## Ouput: 2
##
## 1: 9P
## 2: N + 4P
#
## Example 2
##
## Input: $amount = 15
## Ouput: 6
##
## 1: D + 5P
## 2: D + N
## 3: 3N
## 4: 2N + 5P
## 5: N + 10P
## 6: 15P
#
## Example 3
##
## Input: $amount = 100
## Ouput: 292
#
############################################################
##
## discussion
##
############################################################
#
# Let's use a recursive function. If we can still use the biggest
# available coin, calculate the amount of possible solutions with
# the amount reduced by this coin and add it to the result. In
# any case, calculate the result if the biggest available coin is
# the second available coin in order to find all solutions without the
# biggest coin. Summing those two numbers up yields the result.
# Of course, if the amount for which to calculate the combinations is
# 0, we have found a leaf in the tree of solutions, so we return 1.

use strict;
use warnings;

making_change(9);
making_change(15);
making_change(100);

sub making_change {
   my $amount = shift;
   print "Input: $amount\n";
   my @coins = (50, 25, 10, 5, 1);
   my $result = calculate($amount, @coins);
   print "Output: $result\n";
}

sub calculate {
   my ($amount, @coins) = @_;
   my $result = 0;
   return 1 if $amount <= 0;
   return $result unless @coins;
   if($amount >= $coins[0]) {
      # print "$amount -> $coins[0]\n";
      $result+=calculate($amount - $coins[0], @coins);
   }
   $result += calculate($amount, @coins[1..$#coins]);
   return $result;
}

