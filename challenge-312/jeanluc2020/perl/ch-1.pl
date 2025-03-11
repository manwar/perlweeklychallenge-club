#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-312/#TASK1
#
# Task 1: Minimum Time
# ====================
#
# You are given a typewriter with lowercase english letters a to z arranged in
# a circle.
#
# Typing a character takes 1 sec. You can move pointer one character clockwise
# or anti-clockwise.
#
# The pointer initially points at a.
#
# Write a script to return minimum time it takes to print the given string.
#
## Example 1
##
## Input: $str = "abc"
## Output: 5
##
## The pointer is at 'a' initially.
## 1 sec - type the letter 'a'
## 1 sec - move pointer clockwise to 'b'
## 1 sec - type the letter 'b'
## 1 sec - move pointer clockwise to 'c'
## 1 sec - type the letter 'c'
#
## Example 2
##
## Input: $str = "bza"
## Output: 7
##
## The pointer is at 'a' initially.
## 1 sec - move pointer clockwise to 'b'
## 1 sec - type the letter 'b'
## 1 sec - move pointer anti-clockwise to 'a'
## 1 sec - move pointer anti-clockwise to 'z'
## 1 sec - type the letter 'z'
## 1 sec - move pointer clockwise to 'a'
## 1 sec - type the letter 'a'
#
## Example 3
##
## Input: $str = "zjpc"
## Output: 34
#
############################################################
##
## discussion
##
############################################################
#
# Let's enumerate the characters on the circle with 0 for a
# up to 25 for z. The shortes way to another character is at
# most 13 steps, so we can calculate the difference from one
# character to the next: If that is bigger than 13, we should
# have walked in the opposite direction, which takes (26-steps)
# steps to reach the character. So for each character, we need
# to calculate the steps to walk and the extra second to print,
# of course tracking the new position after each step.
#

use v5.36;

minimum_time("abc");
minimum_time("bza");
minimum_time("zjpc");

sub minimum_time($str) {
   say "Input: \"$str\"";
   my @chars = split //,$str;
   my $ptr = 0;
   my $output = 0;
   foreach my $char (@chars) {
      my $this = ord($char) - 97;
      my $diff = abs($ptr - $this);
      $ptr = $this;
      if($diff > 13) {
         $diff = 26 - $diff;
      }
      $output += $diff; # how many steps to go
      $output++; # printing the character
   }
   say "Output: $output";
}

