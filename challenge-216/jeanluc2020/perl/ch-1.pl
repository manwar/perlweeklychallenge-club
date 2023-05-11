#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-216/#TASK1
#
# Task 1: Registration Number
# ===========================
#
# You are given a list of words and a random registration number.
#
# Write a script to find all the words in the given list that has every letter
# in the given registration number.
#
## Example 1
##
## Input: @words = ('abc', 'abcd', 'bcd'), $reg = 'AB1 2CD'
## Output: ('abcd')
##
## The only word that matches every alphabets in the given registration number
## is 'abcd'.
#
## Example 2
##
## Input: @words = ('job', 'james', 'bjorg'), $reg = '007 JB'
## Output: ('job', 'bjorg')
#
## Example 3
##
## Input: @words = ('crack', 'road', 'rac'), $reg = 'C7 RA2'
## Output: ('crack', 'rac')
#
############################################################
##
## discussion
##
############################################################
#
# We have to check every word in the list whether it matches
# all alphabetical characters in the registration number. If
# it does, we put the word into the result list.
# To check a word, we split the registration number into its
# characters and check if each character is in the word. For that
# we skip numbers and whitespace, then we convert both the
# character and the word to lowercase and check if the character
# is in the word.

use strict;
use warnings;

registration_number('AB1 2CD', 'abc', 'abcd', 'bcd');
registration_number('007 JB', 'job', 'james', 'bjorg');
registration_number('C7 RA2', 'crack', 'road', 'rac');

sub registration_number {
   my ($reg, @words) = @_;
   print "Input: (" . join(", ", @words) . ") - $reg\n";
   my @result = ();
   foreach my $word (@words) {
      push @result, $word if word_matches_all_alphabet($reg, $word);
   }
   print "Output: (" . join(", ", @result) . ")\n";
}

sub word_matches_all_alphabet {
   my ($reg, $word) = @_;
   my @letters = split //, $reg;
   foreach my $letter (@letters) {
      # skip numbers and whitespace
      next if $letter =~ m/^\d$/;
      next if $letter =~ m/^\s$/;
      my $lc_letter = lc($letter);
      return 0 unless lc($word) =~ m/$lc_letter/;
   }
   return 1;
}
