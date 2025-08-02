#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/#TASK1
#
# Task 1: Sort Letters
# ====================
#
# You are given two arrays, @letters and @weights.
#
# Write a script to sort the given array @letters based on the @weights.
#
## Example 1
##
## Input: @letters = ('R', 'E', 'P', 'L')
##        @weights = (3, 2, 1, 4)
## Output: PERL
#
## Example 2
##
## Input: @letters = ('A', 'U', 'R', 'K')
##        @weights = (2, 4, 1, 3)
## Output: RAKU
#
## Example 3
##
## Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
##        @weights = (5, 4, 2, 6, 1, 3)
## Output: PYTHON
#
############################################################
##
## discussion
##
############################################################
#
# Merge the arrays into one so it's easier to sort, then
# concatenate the sorted characters

use strict;
use warnings;

sort_letters( ['R', 'E', 'P', 'L'], [3, 2, 1, 4] );
sort_letters( ['A', 'U', 'R', 'K'], [2, 4, 1, 3] );
sort_letters( ['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3] );

sub sort_letters {
   my ($letters, $weights) = @_;
   my @letters = @$letters;
   print "Input: ('", join("', '", @$letters), "'), (", join(", ", @$weights), ")\n";
   my @combined;
   foreach my $i (0..$#letters) {
      push @combined, [ $letters->[$i], $weights->[$i] ];
   }
   my $output = "";
   foreach my $entry ( sort { $a->[1] <=> $b->[1] } @combined ) {
      $output .= $entry->[0];
   }
   print "Output: $output\n";
}
