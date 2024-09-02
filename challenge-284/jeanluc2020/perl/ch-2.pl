#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-284/#TASK2
#
# Task 2: Relative Sort
# =====================
#
# You are given two list of integers, @list1 and @list2. The elements in the
# @list2 are distinct and also in the @list1.
#
# Write a script to sort the elements in the @list1 such that the relative
# order of items in @list1 is same as in the @list2. Elements that is missing
# in @list2 should be placed at the end of @list1 in ascending order.
#
## Example 1
##
## Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
##        @list2 = (2, 1, 4, 3, 5, 6)
## Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)
#
## Example 2
##
## Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
##        @list2 = (1, 3, 2)
## Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)
#
## Example 3
##
## Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
##        @list2 = (1, 0, 3, 2)
## Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)
#
############################################################
##
## discussion
##
############################################################
#
# First, we turn the second list into a hash with the integers
# as keys and their position inside the array as the values.
# Then we run a clever compare function:
# - if there is an entry for both numbers to be compared, we just
#   compare their position in the original list2.
# - if only one of the two numbers has an entry in the hash, sort
#   this number first
# - if both numbers are missing in list2, then sort by their value

use strict;
use warnings;

relative_sort( [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6] );
relative_sort( [3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2] );
relative_sort( [3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2] );

sub relative_sort {
   my ($list1, $list2) = @_;
   print "Input: (" . join(", ", @$list1) . "),\n       (" . join(", ", @$list2) . ")\n";
   my $int_to_index = {};
   my $i = 0;
   foreach my $elem (@$list2) {
      $int_to_index->{$elem} = $i;
      $i++;
   }
   my @sorted = sort {
      ( defined($int_to_index->{$a}) && defined($int_to_index->{$b}) &&
         $int_to_index->{$a} <=> $int_to_index->{$b} ) ||
      ( defined($int_to_index->{$a}) && -1 ) ||
      ( defined($int_to_index->{$b}) && 1 ) ||
      $a <=> $b
   } @$list1;
   print "Output: (" . join(", ", @sorted) . ")\n";
}
