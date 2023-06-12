#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-220/#TASK1
#
# Task 1: Common Characters
# =========================
#
# You are given a list of words.
#
# Write a script to return the list of common characters (sorted alphabeticall) found in every word of the given list.
#
## Example 1
##
## Input: @words = ("Perl", "Rust", "Raku")
## Output: ("r")
#
## Example 2
##
## Input: @words = ("love", "live", "leave")
## Output: ("e", "l", "v")
#
############################################################
##
## discussion
##
############################################################
#
# We split the word in lowercase into its characters, keeping track
# of each character that is in the word (only count it once per word).
# Then we check which characters appeared as often as there are words.

use strict;
use warnings;

common_characters("Perl", "Rust", "Raku");
common_characters("love", "live", "leave");

sub common_characters {
   my @words = @_;
   print "Input: (" . join(", ", @words) . ")\n";
   my $words = scalar(@words);
   my $data ={};
   foreach my $word (@words) {
      my $seen;
      foreach my $char (split //,lc($word)) {
         $data->{$char}++ unless $seen->{$char}++;
      }
   }
   my $result;
   foreach my $char (sort keys %$data) {
      push @$result, $char if $data->{$char} == $words;
   }
   print "Output: (" . join(", ", @$result) . ")\n";
}

