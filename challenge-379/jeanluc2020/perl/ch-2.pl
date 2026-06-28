#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-379/#TASK2
#
# Task 2: Armstrong Number
# ========================
#
# You are given two integers, $base and $limit.
#
# Write a script to find all Armstrong numbers in base $base that are less than
# $limit.
#
##     If raising each of the digits of a nonnegative integer to the power of
##     the total number of digits, then taking the sum, equals the original
##     number, it is an Armstrong number.
#
## Example 1
##
## Input: $base = 10, $limit = 1000
## Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407)
#
## Example 2
##
## Input: $base = 7, $limit = 1000
## Output: (0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250)
#
## Example 3
##
## Input: $base = 16, $limit = 1000
## Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645)
#
############################################################
##
## discussion
##
############################################################
#
# It's not necessarily obvious, but $limit seems to be in base 10 as
# per the examples. Also the output is in base 10 as well.
# With that in place, we just need to collect all armstrong numbers
# until we hit the limit, so a simple loop will do that.
# In that loop, we check if the given number is an armstrong number
# in the given base:
# - rebase to the given base
# - take the appropriate power of the digits and sum them up
# - if the result equals the original number we can return 1, otherwise 0
# The rest is just helper functions to translate between bases.

use v5.36;

my @base_digits = (0..9, 'a'..'z');

armstrong_numbers(10, 1000);
armstrong_numbers(7, 1000);
armstrong_numbers(16, 1000);

sub translated_to_base10($digit) {
   if($digit =~ m/\d/) {
      return $digit;
   }
   # ord('a') = 97, but we need to start counting at 10 for 'a'.
   return ord($digit) - 87;
}

sub armstrong_numbers($base, $limit) {
   say "Input: base = $base, limit = $limit";
   my @output = ();
   foreach my $number (0..$limit) {
      push @output, $number if is_amstrong_number($number, $base);
   }
   say "Output: (" . join(", ", @output) . ")";
}

sub is_amstrong_number($number, $base) {
   my $rebased_number = rebase($number, $base);
   my $len = length($rebased_number);
   my $r = $rebased_number;
   my $result = 0;
   while(length($r)) {
      $r =~ s/(.)//;
      my $d = $1;
      $result += translated_to_base10($d) ** $len;
   }
   return $result == $number;
}

sub rebase($number, $base) {
   return "0" if $number == 0;
   my $result = "";
   while($number > 0) {
      my $d = $number % $base;
      $result = $base_digits[$d] . $result;
      $number = int($number / $base);
   }
   return $result;
}
