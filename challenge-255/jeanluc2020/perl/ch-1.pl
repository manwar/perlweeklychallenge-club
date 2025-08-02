#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-255/#TASK1
#
# Task 1: Odd Character
# =====================
#
# You are given two strings, $s and $t. The string $t is generated using the
# shuffled characters of the string $s with an additional character.
#
# Write a script to find the additional character in the string $t..
#
## Example 1
##
## Input: $s = "Perl" $t = "Preel"
## Output: "e"
#
## Example 2
##
## Input: $s = "Weekly" $t = "Weeakly"
## Output: "a"
#
## Example 3
##
## Input: $s = "Box" $t = "Boxy"
## Output: "y"
#
############################################################
##
## discussion
##
############################################################
#
# Split the word into its character, store them in a hash table, then
# count the result for each character in both the table for the original
# word and for the new word.

use strict;
use warnings;

odd_character("Perl", "Preel");
odd_character("Weekly", "Weeakly");
odd_character("Box", "Boxy");

sub odd_character {
   my ($s, $t) = @_;
   print "Input: '$s', '$t'\n";
   my $s_hash = {};
   my $t_hash = {};
   foreach my $char (split//,$s) {
      $s_hash->{$char}++;
   }
   foreach my $char (split//,$t) {
      $t_hash->{$char}++;
   }
   foreach my $found (keys %$t_hash) {
      $s_hash->{$found} //= 0;
      if($t_hash->{$found} > $s_hash->{$found}) {
         print "Output: $found\n";
         return;
      }
   }
}
