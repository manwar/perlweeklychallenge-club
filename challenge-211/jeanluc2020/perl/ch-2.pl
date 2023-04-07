#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-211/#TASK2
#
# Task 2: Split Same Average
# ==========================
#
# You are given an array of integers.
#
# Write a script to find out if the given can be split into two separate arrays whose average are the same.
#
## Example 1:
##
## Input: @nums = (1, 2, 3, 4, 5, 6, 7, 8)
## Output: true
##
## We can split the given array into (1, 4, 5, 8) and (2, 3, 6, 7).
## The average of the two arrays are the same i.e. 4.5.
#
## Example 2:
##
## Input: @list = (1, 3)
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# This is basically a problem on how to create all possible
# combinations and checking if any of these allows for the
# same average

use strict;
use warnings;
use List::Util qw(sum);

split_same_average(1, 2, 3, 4, 5, 6, 7, 8);
split_same_average(1, 3);

sub split_same_average {
   my @list = @_;
   print "Input: (" . join(", ", @list) . ")\n";
   if(has_matching_split([@list], [], [])) {
      print "Output: true\n";
   } else {
      print "Output: false\n";
   }
}

# check if the rest of the current list, with two partially
# filled lists from the previous elements, can still be turned
# into two lists that have the same average
# so we create all possible combinations step by step, if we have
# found one we check if it has lead us to two lists of the same
# average, and otherwise return a non-true value (which will lead
# to the next recursive call)
sub has_matching_split {
   my ($rest, $list1, $list2) = @_;
   if(@$rest) {
      # we still have some elements to distribute among the two
      # lists, so we get the first element of this remainder
      my $first = shift @$rest;
      # if by adding this to the first partial list we can achieve
      # a combination where both lists have the same average, we can
      # finish searching and return 1
      if(has_matching_split([@$rest], [@$list1, $first], [@$list2])) {
         return 1;
      }
      # same is true if we can achieve a good combination by adding the
      # element to the second partial list
      if(has_matching_split([@$rest], [@$list1], [@$list2, $first])) {
         return 1;
      }
      # if we didn't succeed either way, we can't find any matching combination
      # that leads to two arrays with the same average, so we return 0
      return 0;
   } else {
      # we have distributed all elements to the two lists, so if both
      # lists are non-empty and share the same average we have found a
      # solution
      if(@$list1 && @$list2 && average(@$list1) == average(@$list2)) {
         return 1;
      }
   }
   return 0;
}

# of course we need a helper function to calculate the average of all
# elements of a list
sub average {
   my @list = @_;
   my $count = @list;
   return undef unless $count;
   my $sum = sum @list;
   return $sum / $count;
}
