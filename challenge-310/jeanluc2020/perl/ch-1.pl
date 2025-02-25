#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-310/#TASK1
#
# Task 1: Arrays Intersection
# ===========================
#
# You are given a list of array of integers.
#
# Write a script to return the common elements in all the arrays.
#
## Example 1
##
## Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
## Output: (1, 4)
#
## Example 2
##
## Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
## Output: (2)
#
## Example 3
##
## Input: $list = ( [1, 2, 3], [4, 5], [6] )
## Output: ()
#
############################################################
##
## discussion
##
############################################################
#
# Let's create a result hash. For reach element of each list, we
# increase the corresponding hash element by 1. In the end, we
# delete all hash elements where the value is less than the number
# of arrays.
# I could have stopped there assuming there won't be any
# duplicates in any of the lists, but the task was not 100% clear
# whether or not duplicates could happen. So I corrected for
# duplicates by counting all elements in a temporary hash for each
# individual list and correct the count in the result hash in
# case a duplicate was found.
#

use v5.36;

array_intersection( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] );
array_intersection( [1, 0, 2, 3], [2, 4, 5] );
array_intersection( [1, 2, 3], [4, 5], [6] );
array_intersection( [1, 2, 3, 4], [4, 5, 6], [4, 2, 1, 3, 4, 1] );

sub array_intersection( @list ) {
   print "Input: (";
   foreach my $l (@list) {
      print "[" . join(", ", @$l) . "], ";
   }
   say ")";
   my $result = {};
   my $count = 0;
   foreach my $l (@list) {
      my $tmp = {};
      $count++;
      map { $result->{$_}++ } @$l;
      map { $tmp->{$_}++ } @$l;
      # correct for duplicates
      foreach my $key (keys %$tmp) {
         my $t = $tmp->{$key};
         if($t > 1) {
            $t--;
            $result->{$key} -= $t;
         }
      }
   }
   foreach my $key (keys %$result ) {
      delete $result->{$key} unless $result->{$key} == $count;
   }
   say "Output: (" . join(", ", sort {$a <=> $b} keys %$result) . ")";
}
