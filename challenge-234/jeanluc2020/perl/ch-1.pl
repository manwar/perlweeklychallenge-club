#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-234/#TASK1
#
# Task 1: Common Characters
# =========================
#
# You are given an array of words made up of alphabetic characters only.
#
# Write a script to return all alphabetic characters that show up in all words
# including duplicates.
#
## Example 1
##
## Input: @words = ("java", "javascript", "julia")
## Output: ("j", "a")
#
## Example 2
##
## Input: @words = ("bella", "label", "roller")
## Output: ("e", "l", "l")
#
## Example 3
##
## Input: @words = ("cool", "lock", "cook")
## Output: ("c", "o")
#
############################################################
##
## discussion
##
############################################################
#
# First, we split each word into its characters, which we count.
# Then, for each character in the first word, we take care the
# value for that character exists for all other words as well, just
# set to 0 if the character doesn't appear in the other word.
# Then we calculate the minimum of times each character is in each
# word, so we can calculate the minimum of occurences for each
# character.
# In the end, we put as many of each character into our result
# set as we found to be the minimum of occurences in each word.

use strict;
use warnings;
use Data::Dumper;

common_characters("java", "javascript", "julia");
common_characters("bella", "label", "roller");
common_characters("cool", "lock", "cook");

sub common_characters {
   my @words = @_;
   print "Input: (" . join(", ", @words) . ")\n";
   my $data;
   foreach my $word (@words) {
      my @chars = split //, $word;
      foreach my $char (@chars) {
         $data->{$word}->{$char}++;
      }
   }
   my $min;
   foreach my $char (keys %{$data->{$words[0]}}) {
      foreach my $word (@words) {
         $data->{$word}->{$char} //= 0;
      }
      $min->{$char} = min( map { $data->{$_}->{$char} } @words );
   }
   my @result;
   foreach my $char (keys %{$data->{$words[0]}}) {
      foreach my $count (1..$min->{$char}) {
         push @result, $char;
      }
   }
   print "Output: (" . join(", ", @result) . ")\n";
}

sub min {
   my @elems = @_;
   my $result = shift @elems;
   foreach my $elem (@elems) {
      $result = $elem if $elem < $result;
   }
   return $result;
}
