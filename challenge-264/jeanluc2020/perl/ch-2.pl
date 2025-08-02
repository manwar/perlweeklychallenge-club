#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-264/#TASK2
#
# Task 2: Target Array
# ====================
#
# You are given two arrays of integers, @source and @indices. The @indices can
# only contains integers 0 <= i < size of @source.
#
# Write a script to create target array by insert at index $indices[i] the
# value $source[i].
#
## Example 1
##
## Input: @source  = (0, 1, 2, 3, 4)
##        @indices = (0, 1, 2, 2, 1)
## Output: (0, 4, 1, 3, 2)
##
## @source  @indices  @target
## 0        0         (0)
## 1        1         (0, 1)
## 2        2         (0, 1, 2)
## 3        2         (0, 1, 3, 2)
## 4        1         (0, 4, 1, 3, 2)
#
## Example 2
##
## Input: @source  = (1, 2, 3, 4, 0)
##        @indices = (0, 1, 2, 3, 0)
## Output: (0, 1, 2, 3, 4)
##
## @source  @indices  @target
## 1        0         (1)
## 2        1         (1, 2)
## 3        2         (1, 2, 3)
## 4        3         (1, 2, 3, 4)
## 0        0         (0, 1, 2, 3, 4)
#
## Example 3
##
## Input: @source  = (1)
##        @indices = (0)
## Output: (1)
#
############################################################
##
## discussion
##
############################################################
#
# Walk the arrays in parallel using an index $i; keep all
# elements < $indices[$i] in your target array, and move
# any elements >= $indices[$i] up by one element, creating
# space for $source->[$i].
# By slicing properly, we can do all of that in a single step.

use strict;
use warnings;

target_array( [0, 1, 2, 3, 4], [0, 1, 2, 2, 1] );
target_array( [1, 2, 3, 4, 0], [0, 1, 2, 3, 0] );
target_array( [1], [0] );

sub target_array {
   my ($source, $indices) = @_;
   print "Input: (", join(", ", @$source), "), (", join(", ", @$indices), ")\n";
   my @target = ();
   foreach my $i (0..scalar(@$indices)-1) {
      my $j = $indices->[$i];
      @target = (@target[0..$j-1], $source->[$i], @target[$j..scalar(@target)-1]);
   }
   print "Output: (", join(", ", @target), ")\n";
}
