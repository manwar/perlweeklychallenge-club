#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-226/#TASK1
#
# Task 1: Shuffle String
# ======================
#
# You are given a string and an array of indices of same length as string.
#
# Write a script to return the string after re-arranging the indices in the correct order.
#
## Example 1
##
## Input: $string = 'lacelengh', @indices = (3,2,0,5,4,8,6,7,1)
## Output: 'challenge'
#
## Example 2
##
## Input: $string = 'rulepark', @indices = (4,7,3,1,0,5,2,6)
## Output: 'perlraku'
#
############################################################
##
## discussion
##
############################################################
#
# Split the string into an array of characters, then walk that
# array and assign each character to the corresponding index of
# a new array.

use strict;
use warnings;

shuffle_string('lacelengh', 3,2,0,5,4,8,6,7,1);
shuffle_string('rulepark', 4,7,3,1,0,5,2,6);

sub shuffle_string {
   my ($string, @indices) = @_;
   print "Input: '$string', (" . join(",", @indices) . ")\n";
   my @chars = split //, $string;
   my @new = ();
   foreach my $i (0..$#chars) {
      $new[$indices[$i]] = $chars[$i];
   }
   print "Output: '" . join("",@new) . "'\n";
}

