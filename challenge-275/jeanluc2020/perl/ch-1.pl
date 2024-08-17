#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-275/#TASK1
#
# Task 1: Broken Keys
# ===================
#
# You are given a sentence, $sentence and list of broken keys @keys.
#
# Write a script to find out how many words can be typed fully.
#
## Example 1
##
## Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
## Output: 0
#
## Example 2
##
## Input: $sentence = "Perl and Raku", @keys = ('a')
## Output: 1
##
## Only Perl since the other word two words contain 'a' and can't be typed fully.
#
## Example 3
##
## Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
## Output: 2
#
## Example 4
##
## Input: $sentence = "The joys of polyglottism", @keys = ('T')
## Output: 2
#
############################################################
##
## discussion
##
############################################################
#
# We split the sentence into its words. Then we create an empty
# temporary list, and walk through the list of broken keys. If a
# word doesn't match the broken key, it will go into the temporary
# list, and at the end of each loop over the broken keys, the new
# list will be the list of words from the sentence that didn't
# match any broken keys so far, while the temporary list will be
# emptied again. This way, at the end of the loop over the broken
# keys, we only have the words that don't match any of the broken
# keys in the final list, of which we return the number of elements.

use strict;
use warnings;

broken_keys( "Perl Weekly Challenge", "l", "a" );
broken_keys( "Perl and Raku", "a" );
broken_keys( "Well done Team PWC", "l", "o" );
broken_keys( "The joys of polyglottism", "T" );

sub broken_keys {
   my ($sentence, @bk ) = @_;
   print "Input: \$sentence = '$sentence', ('", join("', '", @bk), "')\n";
   my @words = split /\s+/, lc($sentence);
   my @tmp = ();
   foreach my $broken (@bk) {
      $broken = lc($broken);
      foreach my $word (@words) {
         push @tmp, $word unless $word =~ m/$broken/;
      }
      @words = @tmp;
      @tmp = ();
   }
   print "Output: ", scalar(@words), "\n";
}

