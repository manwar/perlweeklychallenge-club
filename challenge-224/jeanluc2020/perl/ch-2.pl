#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-224/#TASK2
#
# Task 2: Additive Number
# =======================
#
# You are given a string containing digits 0-9 only.
#
# Write a script to find out if the given string is additive number. An
# additive number is a string whose digits can form an additive sequence.
#
### A valid additive sequence should contain at least 3 numbers. Except the
### first 2 numbers, each subsequent number in the sequence must be the sum of
### the preceding two.
#
## Input: $string = "112358"
## Output: true
##
## The additive sequence can be created using the given string digits: 1,1,2,3,5,8
## 1 + 1 => 2
## 1 + 2 => 3
## 2 + 3 => 5
## 3 + 5 => 8
#
## Example 2:
##
## Input: $string = "12345"
## Output: false
##
## No additive sequence can be created using the given string digits.
#
## Example 3:
##
## Input: $string = "199100199"
## Output: true
##
## The additive sequence can be created using the given string digits: 1,99,100,199
##  1 +  99 => 100
##  99 + 100 => 199
#
############################################################
##
## discussion
##
############################################################
#
# We start by selecting a substring of length l as the first number, with
# 1 <= l <= 1/3*length(string). Then we select another substring starting after
# the first one with the same length restriction. Then, the rest remains as our
# reminder of the string. We now add up the first two strings and compare the
# result to the beginning of the rest with the same length. If that matches,
# our current second string becomes our new first one, the subtring we just cut
# out of the rest is our new second string, and the remainder of the rest after
# cutting out this new second string will be our new rest. If it has zero
# length, we have found an additive number. We recurse down with this function
# until the first two numbers don't match the beginning of the rest or the
# length of the rest is no longer long enough to match the sum, in which cases
# we return 0 and therfore short-curcuit the execution, or we have reached the
# end of the rest with all sums in between matching, so we can return 1.

use strict;
use warnings;

additive_number("112358");
additive_number("12345");
additive_number("199100199");
additive_number("991100101");

sub additive_number {
   my $string = shift;
   my $max_len = length($string) / 3;
   print "Input: $string\n";
   my ($first, $second, $rest);
   foreach my $len1 (1..$max_len) {
      $first = substr($string,0,$len1);
      foreach my $len2 (1..$max_len) {
         $second = substr($string,$len1,$len2);
         $rest = substr($string,$len1+$len2);
         if(is_additive($first, $second, $rest)) {
            print "Output: true\n";
            return;
         }
      }
   }
   print "Output: false\n";
}

sub is_additive {
   my ($first, $second, $rest) = @_;
   my $sum = $first+$second;
   return 0 unless length($rest) >= length($sum);
   my $tmp = substr($rest,0,length($sum));
   my $tmp_rest = substr($rest,length($sum));
   if($tmp != $sum) {
      return 0;
   }
   return 1 if length($tmp_rest) == 0;
   return is_additive($second, $tmp, $tmp_rest);
}
