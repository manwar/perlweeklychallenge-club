#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-313/#TASK1
#
# Task 1: Broken Keys
# ===================
#
# You have a broken keyboard which sometimes type a character more than once.
#
# You are given a string and actual typed string.
#
# Write a script to find out if the actual typed string is meant for the given
# string.
#
## Example 1
##
## Input: $name = "perl", $typed = "perrrl"
## Output: true
##
## Here "r" is pressed 3 times instead of 1 time.
#
## Example 2
##
## Input: $name = "raku", $typed = "rrakuuuu"
## Output: true
#
## Example 3
##
## Input: $name = "python", $typed = "perl"
## Output: false
#
## Example 4
##
## Input: $name = "coffeescript", $typed = "cofffeescccript"
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# We walk $name from left to right and do the same with $typed,
# keeping track of the position in both strings. If at the current
# position, the characters don't match, we compare the character
# in $typed against the previous character from $name because we're
# still fine if we have a match this way. If we're through with $typed,
# but not with $name, we can return "false". Otherwise, once we're
# through with $name we only need to check if all remaining characters
# from $typed are the same as the last character in $name. If we have
# any remainder in $typed, then we can return false as well.
# If we've used up all characters from both strings successfully, we
# can return "true".

use v5.36;

broken_keys("perl", "perrrl");
broken_keys("raku", "rrakuuuu");
broken_keys("python", "perl");
broken_keys("coffeescript", "cofffeescccript");

sub broken_keys($name, $typed) {
   say "Input: \"$name\", \"$typed\"";
   my @name = split //, $name;
   my @typed = split //, $typed;
   my $prev = "";
   my $j = 0;
   foreach my $i (0..$#name) {
      if($name[$i] eq $typed[$j]) {
         $j++;
         $prev = $name[$i];
         next;
      }
      while($prev eq $typed[$j]) {
         $j++;
      }
      $prev = $name[$i];
      if($j > $#typed and $i < $#name) {
         return say "Output: false";
      }
   }
   while($j < $#typed and $prev eq $typed[$j]) {
      $j++;
   }
   if($j < $#typed) {
      return say "Output: false";
   }
   say "Output: true";
}
