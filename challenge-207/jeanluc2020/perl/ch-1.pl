#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-207/#TASK1
#
# Task 1: Keyboard Word
# =====================
#
# You are given an array of words.
#
# Write a script to print all the words in the given array that can be types using alphabet on only one row of the keyboard.
#
# Let us assume the keys are arranged as below:
#
# Row 1: qwertyuiop
# Row 2: asdfghjkl
# Row 3: zxcvbnm
#
## Example 1
##
## Input: @words = ("Hello","Alaska","Dad","Peace")
## Output: ("Alaska","Dad")
#
## Example 2
##
## Input: @array = ("OMG","Bye")
## Output: ()
#
############################################################
##
## discussion
##
############################################################
#
# Basically, for all input words, we create the same word in
# lowercase and for each keyboard row, we check whether we can
# build this word with this row and add it to the output if we
# can

use strict;
use warnings;
use feature 'say';

keyboard_word("Hello","Alaska","Dad","Peace");
keyboard_word("OMG","Bye");

sub keyboard_word {
   my @words = @_;
   my @output = ();
   foreach my $word (@words) {
      # if the lowercase "lc()" version of $word is a keyboard
      # word, we can push the word onto the output
      push @output, $word if is_keyboard_word(lc($word));
   }
   say "Input: (" . join(",", @words) . ")";
   say "Output: (" . join(",", @output) . ")";
}

sub is_keyboard_word {
   my $word = shift;
   my @rows = ( "qwertyuiop", "asdfghjkl", "zxcvbnm");
   my @chars = split //, $word;
   foreach my $row (@rows) {
      # if $found_all is still 1 after all characters have been
      # found in the current row, we found a keyboard word
      my $found_all = 1;
      foreach my $char (@chars) {
         if($row !~ m/$char/) {
            # we found a character that is not in this row
            $found_all = 0;
         }
      }
      return 1 if $found_all;
   }
   # we haven't found all characters in the same row for all rows
   return 0;
}
