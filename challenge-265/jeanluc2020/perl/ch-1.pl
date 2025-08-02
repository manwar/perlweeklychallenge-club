#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-265/#TASK1
#
# Task 1: 33% Appearance
# ======================
#
# You are given an array of integers, @ints.
#
# Write a script to find an integer in the given array that appeared 33% or
# more. If more than one found, return the smallest. If none found then return
# undef.
#
## Example 1
##
## Input: @ints = (1,2,3,3,3,3,4,2)
## Output: 3
##
## 1 appeared 1 times.
## 2 appeared 2 times.
## 3 appeared 4 times.
##
## 3 appeared 50% (>33%) in the given array.
#
## Example 2
##
## Input: @ints = (1,1)
## Output: 1
##
## 1 appeared 2 times.
##
## 1 appeared 100% (>33%) in the given array.
#
## Example 3
##
## Input: @ints = (1,2,3)
## Output: 1
##
## 1 appeared 1 times.
## 2 appeared 1 times.
## 3 appeared 1 times.
##
## Since all three appeared 33.3% (>33%) in the given array.
## We pick the smallest of all.
#
############################################################
##
## discussion
##
############################################################
#
# For each element in the array, count the number of occurences.
# Then, we can start with the smallest of those numbers and check
# whether or not it has more than 33% appearances. If yes we are
# finished and return the found number, otherwise we continue.
# If we're at the end and didn't find any number that appeared
# at least 33% of the time we can return undef.

use strict;
use warnings;

thirty_three_appearance(1,2,3,3,3,3,4,2);
thirty_three_appearance(1,1);
thirty_three_appearance(1,2,3);
thirty_three_appearance(1,2,3,4);

sub thirty_three_appearance {
   my @ints = @_;
   my $found = {};
   my $count = scalar(@ints);
   my $limit = 33/100;
   my $appeared = undef;
   print "Input: (" . join(", ", @ints) . ")\n";
   foreach my $i (@ints) {
      $found->{$i}++;
   }
   foreach my $j (sort {$a<=>$b} keys %$found) {
      if(($found->{$j}/$count) >= $limit) {
         $appeared = $j;
         last;
      }
   }
   if(defined($appeared)) {
      print "Output: $appeared\n";
   } else {
      print "Output: undef\n";
   }
}
