#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-266/#TASK1
#
# Task 1: Uncommon Words
# ======================
#
# You are given two sentences, $line1 and $line2.
#
# Write a script to find all uncommmon words in any order in the given two
# sentences. Return ('') if none found.
#
### A word is uncommon if it appears exactly once in one of the sentences and
### doesn’t appear in other sentence.
#
## Example 1
##
## Input: $line1 = 'Mango is sweet'
##        $line2 = 'Mango is sour'
## Output: ('sweet', 'sour')
#
## Example 2
##
## Input: $line1 = 'Mango Mango'
##        $line2 = 'Orange'
## Output: ('Orange')
#
## Example 3
##
## Input: $line1 = 'Mango is Mango'
##        $line2 = 'Orange is Orange'
## Output: ('')
#
############################################################
##
## discussion
##
############################################################
#
# The task is to find word that only appear once across two sentence.
# So we split the sentences into the single words and count each one.
# We can avoid creating two loops by concatenating the two sentences
# first. 

use strict;
use warnings;

uncommon_words('Mango is sweet', 'Mango is sour');
uncommon_words('Mango Mango', 'Orange');
uncommon_words('Mango is Mango', 'Orange is Orange');

sub uncommon_words {
   my ($line1, $line2) = @_;
   print "Input: '$line1', '$line2'\n";
   my $words = {};
   my @output = ();
   foreach my $word (split /\s+/, "$line1 $line2") {
      $words->{$word}++
   }
   foreach my $word (keys %$words) {
      push @output, $word if $words->{$word} == 1;
   }
   if(@output) {
      print "Output: ('", join("', '", @output), "')\n";
   } else {
      print "Output: ('')\n";
   }
}
