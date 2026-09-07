#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-387/#TASK1
#
# Task 1: Rearrange Binary String
# ===============================
#
# You are given a binary string string.
#
# Write a script to re-arrange the given binary string that all occurrences of
# “01” are simultaneously replaced with “10” until no occurrences of “01”
# exist. Finally return the total steps needed.
#
## Example 1
##
## Input: $str = "111000"
## Output: 0
##
## The string already has all 1s on the left and 0s on the right.
## There are no occurrences of "01", so zero step needed.
#
## Example 2
##
## Input: $str = "00011"
## Output: 4
##
## Step 1: "00101"
## Step 2: "01010"
## Step 3: "10100"
## Step 4: "11000"
#
## Example 3
##
## Input: $str = "01011"
## Output: 3
##
## Step 1: "10101"
## Step 2: "11010"
## Step 3: "11100"
#
## Example 4
##
## Input: $str = "010101"
## Output: 3
##
## Step 1: "101010"
## Step 2: "110100"
## Step 3: "111000"
#
## Example 5
##
## Input: $str = "00001"
## Output: 4
##
## Step 1: "00010"
## Step 2: "00100"
## Step 3: "01000"
## Step 4: "10000"
#
############################################################
##
## discussion
##
############################################################
#
# While the string still contains "01" as a substring, replace
# all "01" for "10". Count how many steps were taken.

use v5.36;

rearrange_binary_string("111000");
rearrange_binary_string("00011");
rearrange_binary_string("01011");
rearrange_binary_string("010101");
rearrange_binary_string("00001");

sub rearrange_binary_string($str) {
   say "Input: \"$str\"";
   my $count = 0;
   while($str =~ m/01/) {
      $str =~ s/01/10/g;
      $count++;
   }
   say "Output: $count";
}
