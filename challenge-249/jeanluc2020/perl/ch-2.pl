#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-249/#TASK2
#
# Task 2: DI String Match
# =======================
#
# You are given a string s, consisting of only the characters "D" and "I".
#
# Find a permutation of the integers [0 .. length(s)] such that for each
# character s[i] in the string:
#
# s[i] == 'I' ⇒ perm[i] < perm[i + 1]
# s[i] == 'D' ⇒ perm[i] > perm[i + 1]
#
## Example 1
##
## Input: $str = "IDID"
## Output: (0, 4, 1, 3, 2)
#
## Example 2
##
## Input: $str = "III"
## Output: (0, 1, 2, 3)
#
## Example 3
##
## Input: $str = "DDI"
## Output: (3, 2, 0, 1)
#
############################################################
##
## discussion
##
############################################################
#
# We just count from 0 to length(s) for each "I" and from
# length(s) to 0 for each "D", and in the end add the last
# element we didn't use up yet.

use strict;
use warnings;

DI_string_match("IDID");
DI_string_match("III");
DI_string_match("DDI");

sub DI_string_match {
   my $str = shift;
   print "Input: '$str'\n";
   my $upper = length($str);
   my $lower = 0;
   my @result = ();
   foreach my $char (split//,$str) {
      if($char eq "I") {
         push @result, $lower++;
      } else {
         push @result, $upper--;
      }
   }
   push @result, $lower;
   print "Output: (", join(", ", @result), ")\n";
}
