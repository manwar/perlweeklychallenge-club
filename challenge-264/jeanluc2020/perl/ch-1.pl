#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-264/#TASK1
#
# Task 1: Greatest English Letter
# ===============================
#
# You are given a string, $str, made up of only alphabetic characters [a..zA..Z].
#
# Write a script to return the greatest english letter in the given string.
#
### A letter is greatest if it occurs as lower and upper case. Also letter
### ‘b’ is greater than ‘a’ if ‘b’ appears after ‘a’ in the English alphabet.
#
## Example 1
##
## Input: $str = 'PeRlwEeKLy'
## Output: L
##
## There are two letters E and L that appears as lower and upper.
## The letter L appears after E, so the L is the greatest english letter.
#
## Example 2
##
## Input: $str = 'ChaLlenge'
## Output: L
#
## Example 3
##
## Input: $str = 'The'
## Output: ''
#
############################################################
##
## discussion
##
############################################################
#
# First, we split the input string into its characters. We then
# calculate the lowercase version of the character. We fill some
# data into a hash of hashes:
# - The key of the outermost hash is the lowercase version of the
#   character
# - The key of the inner hash is the character in its original form
# - The value of the inner hash is just a true value
# This way, if both the upper- and lowercase form of a character are
# in the input string, the corresponding inner hash for the character
# will have two keys (the upper- and lowercase version).
# Now we simply walk through the reverse sorted keys of the outer hash.
# As soon as we find a character that has both upper- and lowercase
# versions in its inner hash, we have found the Greatest English Letter
# and can finish the loop.

use strict;
use warnings;

greatest_english_letter('PeRlwEeKLy');
greatest_english_letter('ChaLlenge');
greatest_english_letter('The');

sub greatest_english_letter {
   my $str = shift;
   print "Input: '$str'\n";
   my $all = {};
   my $output = "''";
   foreach my $c (split(//, $str)) {
      $all->{lc($c)}->{$c} = 1;
   }
   foreach my $c (reverse sort keys %$all) {
      next unless scalar(keys %{ $all->{$c} }) == 2;
      $output = uc($c);
      last;
   }
   print "Output: $output\n";
}
