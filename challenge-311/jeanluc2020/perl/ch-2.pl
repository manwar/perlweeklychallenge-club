#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-311/#TASK2
#
# Task 2: Group Digit Sum
# =======================
#
# You are given a string, $str, made up of digits, and an integer, $int, which is less than the length of the given string.
#
# Write a script to divide the given string into consecutive groups of size $int
# (plus one for leftovers if any). Then sum the digits of each group, and
# concatenate all group sums to create a new string. If the length of the new
# string is less than or equal to the given integer then return the new string,
# otherwise continue the process.
#
## Example 1
##
## Input: $str = "111122333", $int = 3
## Output: "359"
##
## Step 1: "111", "122", "333" => "359"
#
## Example 2
##
## Input: $str = "1222312", $int = 2
## Output: "76"
##
## Step 1: "12", "22", "31", "2" => "3442"
## Step 2: "34", "42" => "76"
#
## Example 3
##
## Input: $str = "100012121001", $int = 4
## Output: "162"
##
## Step 1: "1000", "1212", "1001" => "162"
#
############################################################
##
## discussion
##
############################################################
#
# As long as $str is bigger than $int, do a loop:
# - split $str into its parts, store those in a temporary array
# - calculate the sum of digits for each of those parts, store
#   those sums into another temporary array
# - concatenate those sums, forming the new $str
# - repeat until the length of $str <= $int
# - return the result

use v5.36;
use List::Util qw(sum);

group_digit_sum("111122333", 3);
group_digit_sum("1222312", 2);
group_digit_sum("100012121001", 4);


sub group_digit_sum($str, $int) {
   say "Input: \$str = \"$str\", \$int = $int";
   my $sum = 0;
   while(length($str) > $int) {
      my @tmp = ();
      while(length($str) > $int) {
         push @tmp, substr($str, 0, $int);
         $str = substr($str, $int);
      }
      push @tmp, $str;
      my @sums = ();
      foreach my $elem (@tmp) {
         my @parts = split//, $elem;
         push @sums, sum(@parts);
      }
      $str = join("", @sums);
   }
   say "Output: $str";
}
