#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-380/#TASK1
#
# Task 1: Sum of Frequencies
# ==========================
#
# You are given a string consisting of English letters.
#
# Write a script to find the vowel and consonant with maximum frequency. Return
# the sum of two frequencies.
#
## Example 1
##
## Input: $str = "banana"
## Output: 5
##
## Vowel: "a" appears 3 times.
## Consonant: "n" appears 2 times, "b" appears 1 time.
##
## Max frequency of vowel: 3
## Max frequency of consonant: 2
#
## Example 2
##
## Input: $str = "teestett"
## Output: 7
##
## Vowel: "e" appears 3 times.
## Consonant: "t" appears 4 times, "s" appears 1 time.
##
## Max frequency of vowel: 3
## Max frequency of consonant: 4
#
## Example 3
##
## Input: $str = "aeiouuaa"
## Output: 3
##
## Vowel: "a" appears 3 times, "u" 2 times, "e", "i", "o" 1 time each.
## Consonant: None.
##
## Max frequency of vowel: 3
## Max frequency of consonant: 0
#
## Example 4
##
## Input: $str = "rhythm"
## Output: 2
##
## Vowel: None
## Consonant: "h" appears 2 times, "r", "y", "t", "m" 1 time each.
##
## Max frequency of vowel: 0
## Max frequency of consonant: 2
#
## Example 5
##
## Input: $str = "x"
## Output: 1
##
## Vowel: None
## Consonant: "x" appears 1 time.
##
## Max frequency of vowel: 0
## Max frequency of consonant: 1
#
############################################################
##
## discussion
##
############################################################
#
# We count all vowels / consonants properly, storing the count
# in a hash for each. Then we just need to add the maximum
# of the values in both hashes.

use v5.36;
use List::Util qw(max);

sum_of_frequencies( "banana" );
sum_of_frequencies( "teestett" );
sum_of_frequencies( "aeiouuaa" );
sum_of_frequencies( "rhythm" );
sum_of_frequencies( "x" );

sub sum_of_frequencies($str) {
   say "Input: \"$str\"";
   my $vowels = { "a" => 0 };
   my $consonants = { "b" => 0 };
   foreach my $char (split //, $str) {
      if($char =~ m/[aeiou]/) {
         $vowels->{$char}++;
      } else {
         $consonants->{$char}++;
      }
   }
   say "Output: " . (max(values(%$vowels)) + max(values(%$consonants)));
}
