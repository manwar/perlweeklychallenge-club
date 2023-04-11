#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-212/#TASK1
#
# Task 1: Jumping Letters
# =======================
#
# You are given a word having alphabetic characters only, and a list of
# positive integers of the same length
#
# Write a script to print the new word generated after jumping forward each
# letter in the given word by the integer in the list. The given list would
# have exactly the number as the total alphabets in the given word.
#
## Example 1
##
## Input: $word = 'Perl' and @jump = (2,22,19,9)
## Output: Raku
##
## 'P' jumps 2 place forward and becomes 'R'.
## 'e' jumps 22 place forward and becomes 'a'. (jump is cyclic i.e. after 'z' you go back to 'a')
## 'r' jumps 19 place forward and becomes 'k'.
## 'l' jumps 9 place forward and becomes 'u'.
#
## Example 2
##
## Input: $word = 'Raku' and @jump = (24,4,7,17)
## Output: 'Perl'
#
############################################################
##
## discussion
##
############################################################
#
# Going character by character, apply the jump. Just check if we
# are in a lower- or uppercase character first to jump in the
# right space.

use strict;
use warnings;

jumping_letters("Perl", [2,22,19,9]);
jumping_letters("Raku", [24,4,7,17]);

sub jumping_letters {
   my ($word, $jump) = @_;
   my @chars = split //, $word;
   my $result;
   print "Input: $word - [" . join(",", @$jump) . "]\n";
   foreach my $i (0..$#chars) {
      $result .= jumping_letter($chars[$i], $jump->[$i]);
   }
   print "Output: $result\n";
}

# jump a single letter
sub jumping_letter {
   my ($chr, $jump) = @_;
   my $o = ord($chr);
   if(65 <= $o && $o <= 90) {
      # uppercase letter
      $o += $jump || 0;
      # we need to wrap around since we
      # jumped past "Z"
      if($o > 90) {
         $o -= 26;
      }
      return chr($o);
   } else {
      # lowercase character
      $o += $jump || 0;
      # we need to wrap around since we
      # jumped past "z"
      if($o > 122) {
         $o -= 26;
      }
      return chr($o);
   }
}

