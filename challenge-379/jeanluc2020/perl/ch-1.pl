#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-379/#TASK1
#
# Task 1: Reverse String
# ======================
#
# You are given a string.
#
# Write a script to reverse the given string without using standard reverse
# function.
#
## Example 1
##
## Input: $str = ""
## Output: ""
#
## Example 2
##
## Input: $str = "reverse the given string"
## Output: "gnirts nevig eht esrever"
#
## Example 3
##
## Input: $str = "Perl is Awesome"
## Output: "emosewA si lreP"
#
## Example 4
##
## Input: $str = "v1.0.0-Beta!"
## Output: "!ateB-0.0.1v"
#
## Example 5
##
## Input: $str = "racecar"
## Output: "racecar"
#
############################################################
##
## discussion
##
############################################################
#
# Since we can't use reverse(), we just cut the first character as
# long as the string still has characters, and put it in front of
# the result string.

use v5.36;

reverse_string("");
reverse_string("reverse the given string");
reverse_string("Perl is Awesome");
reverse_string("v1.0.0-Beta!");
reverse_string("racecar");

sub reverse_string($str) {
   say "Input: \"$str\"";
   my $result = "";
   while(length($str) > 0) {
      $str =~ s/(.)//;
      $result = $1 . $result;
   }
   say "Output: \"$result\"";
}
