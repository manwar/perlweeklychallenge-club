#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-273/#TASK1
#
# Task 1: Percentage of Character
# ===============================
#
# You are given a string, $str and a character $char.
#
# Write a script to return the percentage, nearest whole, of given character in
# the given string.
#
## Example 1
##
## Input: $str = "perl", $char = "e"
## Output: 25
#
## Example 2
##
## Input: $str = "java", $char = "a"
## Output: 50
#
## Example 3
##
## Input: $str = "python", $char = "m"
## Output: 0
#
## Example 4
##
## Input: $str = "ada", $char = "a"
## Output: 67
#
## Example 5
##
## Input: $str = "ballerina", $char = "l"
## Output: 22
#
## Example 6
##
## Input: $str = "analitik", $char = "k"
## Output: 13
#
############################################################
##
## discussion
##
############################################################
#
# We split $str into its characters and count both the overall
# sum and the sum of the characters that match $char. We calculate
# the percentage, add 0.5 and convert to an integer. This way, we
# obtain the nearest whole percentage.

use strict;
use warnings;

percentage_of_char("perl", "e");
percentage_of_char("java", "a");
percentage_of_char("python", "m");
percentage_of_char("ada", "a");
percentage_of_char("ballerina", "l");
percentage_of_char("analitik", "k");

sub percentage_of_char {
   my ($str, $char) = @_;
   print "Input: '$str', '$char'\n";
   my $overall_char_count = 0;
   my $this_char_count = 0;
   foreach my $c (split //, $str) {
      $overall_char_count++;
      $this_char_count++ if $c eq $char;
   }
   my $percentage = int(100*$this_char_count/$overall_char_count + 0.5);
   print "Output: $percentage\n";
}
