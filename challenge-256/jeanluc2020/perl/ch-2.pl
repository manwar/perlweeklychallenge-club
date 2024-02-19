#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-256/#TASK2
#
# Task 2: Merge Strings
# =====================
#
# You are given two strings, $str1 and $str2.
#
# Write a script to merge the given strings by adding in alternative order
# starting with the first string. If a string is longer than the other then
# append the remaining at the end.
#
## Example 1
##
## Input: $str1 = "abcd", $str2 = "1234"
## Output: "a1b2c3d4"
#
## Example 2
##
## Input: $str1 = "abc", $str2 = "12345"
## Output: "a1b2c345"
#
## Example 3
##
## Input: $str1 = "abcde", $str2 = "123"
## Output: "a1b2c3de"
#
############################################################
##
## discussion
##
############################################################
#
# Turn both strings into arrays, get elements from both arrays
# until the first one is empty, then add the remainder of the
# second one.

use strict;
use warnings;

merge_strings("abcd", "1234");
merge_strings("abc", "12345");
merge_strings("abcde", "123");

sub merge_strings {
   my ($str1, $str2) = @_;
   print "Input: str1 = \"$str1\", str2 = \"$str2\"\n";
   my $output = "";
   my @first = split //, $str1;
   my @second = split //, $str2;
   while (my $c = shift @first) {
      $output .= $c;
      $output .= shift @second // "";
   }
   $output .= join("", @second);
   print "Output: \"$output\"\n";
}
