#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-272/#TASK2
#
# Task 2: String Score
# ====================
#
# You are given a string, $str.
#
# Write a script to return the score of the given string.
#
### The score of a string is defined as the sum of the absolute difference
### between the ASCII values of adjacent characters.
#
## Example 1
##
## Input: $str = "hello"
## Output: 13
##
## ASCII values of characters:
## h = 104
## e = 101
## l = 108
## l = 108
## o = 111
##
## Score => |104 - 101| + |101 - 108| + |108 - 108| + |108 - 111|
##       => 3 + 7 + 0 + 3
##       => 13
#
## Example 2
##
## Input: "perl"
## Output: 30
##
## ASCII values of characters:
## p = 112
## e = 101
## r = 114
## l = 108
##
## Score => |112 - 101| + |101 - 114| + |114 - 108|
##       => 11 + 13 + 6
##       => 30
#
## Example 3
##
## Input: "raku"
## Output: 37
##
## ASCII values of characters:
## r = 114
## a = 97
## k = 107
## u = 117
##
## Score => |114 - 97| + |97 - 107| + |107 - 117|
##       => 17 + 10 + 10
##       => 37
#
############################################################
##
## discussion
##
############################################################
#
# Split the string into an array of characters. Then start at
# index 1 and calculate the diff of the ASCII values of the
# character at the given index-1 and the given index, until the
# index reaches the index of the last element in the array. The
# ASCII value can be calculated by the ord() function, the absolute
# value of the diff will be revealed by the abs() function.

use strict;
use warnings;

string_score("hello");
string_score("perl");
string_score("raku");

sub string_score {
   my $str = shift;
   print "Input: '$str'\n";
   my @chars = split //, $str;
   my $score = 0;
   foreach my $i (1..$#chars) {
      $score += abs(ord($chars[$i-1]) - ord($chars[$i]));
   }
   print "Output: $score\n";
}

