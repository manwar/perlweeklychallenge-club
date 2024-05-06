#!/bin/perl

=pod

The Weekly Challenge - 268
- https://theweeklychallenge.org/blog/perl-weekly-challenge-268

Author: Niels 'PerlBoy' van Dijke

Task 2: Number Game
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, with even number of elements.

Write a script to create a new array made up of elements of the given
array. Pick the two smallest integers and add it to new array in
decreasing order i.e. high to low. Keep doing until the given array is
empty.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(all pairs pairwise);

sub numberGame(@ints) {
  my @before = @ints;
  my @after;
  while (1) {
    push(@after,sort{$b<=>$a}@$_) for (pairs(sort{$a<=>$b}@before));
    last if (all{$_ == 0} pairwise {$a-$b} @before,@after);
    @before = @after; @after = ();
  }
  return @after;
}

is([numberGame(2,5,3,4)],[3,2,5,4],'Example 1');
is([numberGame(9,4,1,3,6,4,6,1)],[1,1,4,3,6,4,9,6],'Example 2');
is([numberGame(1,2,2,3)],[2,1,3,2],'Example 3');

done_testing;
