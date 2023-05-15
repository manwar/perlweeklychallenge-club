#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-217/#TASK2
#
# Task 2: Max Number
# ==================
#
# You are given a list of positive integers.
#
# Write a script to concatenate the integers to form the highest possible value.
#
## Example 1:
##
## Input: @list = (1, 23)
## Output: 231
#
## Example 2:
##
## Input: @list = (10, 3, 2)
## Output: 3210
#
## Example 3:
##
## Input: @list = (31, 2, 4, 10)
## Output: 431210
#
## Example 4:
##
## Input: @list = (5, 11, 4, 1, 2)
## Output: 542111
#
## Example 5:
##
## Input: @list = (1, 10)
## Output: 110
#
############################################################
##
## discussion
##
############################################################
#
# We simply create all possible permutations of the input list.
# Each permutation represents one possible value, so we just
# pick the highest value.

use strict;
use warnings;

max_number(1, 23);
max_number(10, 3, 2);
max_number(31, 2, 4, 10);
max_number(5, 11, 4, 1, 2);
max_number(1, 10);

sub max_number {
   my @list = @_;
   print "Input: (" . join(", ", @list) . ")\n";
   print "Output: " . get_max(@list) . "\n";
}

sub get_max {
   my @list = @_;
   return "" unless @list;
   my $max = 0;
   foreach my $index (0..$#list) {
      my @rest = ();
      @rest = @list[0..$index-1] if $index > 0;
      push @rest, @list[$index+1..$#list] if $index < $#list;
      my $current = $list[$index] . get_max(@rest);
      $max = $current if $current > $max;
   }
   return $max;
}

