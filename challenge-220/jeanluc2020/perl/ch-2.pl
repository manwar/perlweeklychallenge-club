#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-220/#TASK2
#
# Task 2: Squareful
# =================
#
# You are given an array of integers, @ints.
#
### An array is squareful if the sum of every pair of adjacent elements is a perfect square.
#
# Write a script to find all the permutations of the given array that are squareful.
#
## Example 1:
##
## Input: @ints = (1, 17, 8)
## Output: (1, 8, 17), (17, 8, 1)
##
## (1, 8, 17) since 1 + 8 => 9, a perfect square and also 8 + 17 => 25 is perfect square too.
## (17, 8, 1) since 17 + 8 => 25, a perfect square and also 8 + 1 => 9 is perfect square too.
#
## Example 2:
##
## Input: @ints = (2, 2, 2)
## Output: (2, 2, 2)
##
## There is only one permutation possible.
#
############################################################
##
## discussion
##
############################################################
#
# This one uses a few helper functions.
# 1. permutations() takes an array of integers and returns all
#    possible permutations of that array as an array of
#    array references
# 2. uniq() takes the output of permutations() and removes
#    all duplicates (which can happen if the same integer is
#    in the original array more often than once)
# 3. not_found() returns 1 if an array reference (given as
#    first arg) doesn't point to an array that has the same
#    contents as one of the following array references, and 0
#    if there is already an array reference that points to an
#    array with the same contents
# 4. is_squareful() checks if a given array of integers is
#    squareful in which case it returns 1 (otherwise 0)
# The rest is easy: push each unique permutation onto the result
# if it is squareful.
use strict;
use warnings;
use Data::Dumper;

squareful(1, 17, 8);
squareful(2, 2, 2);

sub squareful {
   my @ints = @_;
   my @result;
   print "Input: (" . join(", ", @ints) . ")\n";
   foreach my $permutation (uniq(permutations(@ints))) {
      push @result, $permutation if is_squareful(@$permutation);
   }
   print "Output: ";
   my $first = 1;
   foreach my $permutation (@result) {
      print ", " unless $first;
      $first = 0;
      print "(" . join(", ", @$permutation) . ")";
   }
   print "\n";
}

# We check wether an array of integers is squareful by
# calculating the square root of the sum of two adjacent
# numbers in the array. If that square root is the same
# as it is when rounded to an integer, we have found a square
# which means the array is not squareful if that's not the
# case.
sub is_squareful {
   my @ints = @_;
   my $result = 1;
   foreach my $index (0..$#ints-1) {
      my $root = sqrt($ints[$index]+$ints[$index+1]);
      return 0 unless $root == int($root);
   }
   return $result;
}

# produce all possible permutations recursively:
# pick each element of the array as the first element for a set
# of permutations, then calculate all permutations of the remainder
# of the array, and push each of those with that selected first element
# onto the result set
sub permutations {
   my @array = @_;
   return () unless @array;
   my @result;
   foreach my $index (0..$#array) {
      my @tmp = permutations(@array[0..$index-1], @array[$index+1..$#array]);
      if(@tmp) {
         foreach my $permutation (@tmp) {
            push @result, [ $array[$index], @$permutation ];
         }
      } else {
            push @result, [ $array[$index] ];
      }
   }
   return @result;
}

# take each array from the input and push it onto the result
# set if it isn't already there
sub uniq {
   my @array = @_;
   my @result = ();
   foreach my $elem (@array) {
      if(not_found($elem,@result)) {
         push @result, $elem;
      }
   }
   return @result;
}

# if the given first array (given by reference) isn't
# already in the found arrays (also given by reference)
# we return 1, otherwise 0.
sub not_found {
   my ($array_ref, @found) = @_;
   my $elems = scalar(@$array_ref) - 1;
   return 1 unless @found;
   foreach my $exists (@found) {
      foreach my $index (0..$elems) {
         return 1 if $array_ref->[$index] != $exists->[$index];
      }
   }
   return 0;
}
