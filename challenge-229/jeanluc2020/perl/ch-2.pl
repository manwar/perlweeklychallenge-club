#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-229/#TASK2
#
# Task 2: Two out of Three
# ========================
#
# You are given three array of integers.
#
# Write a script to return all the elements that are present in at least 2 out of 3 given arrays.
#
## Example 1
##
## Input: @array1 = (1, 1, 2, 4)
##        @array2 = (2, 4)
##        @array3 = (4)
## Ouput: (2, 4)
#
## Example 2
##
## Input: @array1 = (4, 1)
##        @array2 = (2, 4)
##        @array3 = (1, 2)
## Ouput: (1, 2, 4)
#
############################################################
##
## discussion
##
############################################################
#
# First, we generate a list of unique elements per array.
# Second, we count how many times each element in those unique
# lists appear altogether. If that happens to be at least 2
# times we found an element for our result. Since sorting those
# elements can easily be done when enumerating them, let's
# just do that as well.

use strict;
use warnings;

two_out_of_three( [1, 1, 2, 4], [2, 4], [4] );
two_out_of_three( [4, 1], [2, 4], [1, 2] );

sub two_out_of_three {
   my ($array1, $array2, $array3) = @_;
   print "Input: \@array1 = (" . join(", ", @$array1) . ")\n";
   print "       \@array2 = (" . join(", ", @$array2) . ")\n";
   print "       \@array3 = (" . join(", ", @$array3) . ")\n";
   my @uniq_array1 = my_uniq(@$array1);
   my @uniq_array2 = my_uniq(@$array2);
   my @uniq_array3 = my_uniq(@$array3);
   my %seen;
   my @output = ();
   foreach my $elem ( (@uniq_array1, @uniq_array2, @uniq_array3) ) {
      $seen{$elem}++;
   }
   foreach my $found (sort {$a <=> $b} keys %seen) {
      push @output, $found if $seen{$found} >= 2;
   }
   print "Output: (" . join(", ", @output) . ")\n";
}

sub my_uniq {
   my @array = @_;
   my $found = {};
   map { $found->{$_}++ } @array;
   return keys %$found;
}
