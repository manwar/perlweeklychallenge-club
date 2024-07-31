#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/#TASK2
#
# Task 2: Split String
# ====================
#
# You are given a string, $str.
#
# Write a script to split the given string into two containing exactly same
# number of vowels and return true if you can otherwise false.
#
## Example 1
##
## Input: $str = "perl"
## Ouput: false
#
## Example 2
##
## Input: $str = "book"
## Ouput: true
##
## Two possible strings "bo" and "ok" containing exactly one vowel each.
#
## Example 3
##
## Input: $str = "good morning"
## Ouput: true
##
## Two possible strings "good " and "morning" containing two vowels each or
## "good m" and "orning" containing two vowels each.
#
############################################################
##
## discussion
##
############################################################
#
# We turn $str into an array of characters, then we check at each position
# whether a split right there would create two substrings with the same
# amount of vowels.
# A helper function takes care of counting the vowels in an array of characters.

use strict;
use warnings;

split_string("perl");
split_string("book");
split_string("good morning");

sub split_string {
   my $str = shift;
   print "Input: \"$str\"\n";
   my @letters = split //, $str;
   foreach my $i (0..$#letters) {
      return print "Output: true\n" if count_vowels(@letters[0..$i]) == count_vowels(@letters[$i+1..$#letters]);
   }
   return print "Output: false\n";
}

sub count_vowels {
   my @chars = @_;
   my $count = 0;
   my $vowels = { a => 1, e => 1, i => 1, o => 1, u => 1,
      A => 1, E => 1, I => 1, O => 1, U => 1, };
   foreach my $char (@chars) {
      $count++ if $vowels->{$char};
   }
   return $count;
}
