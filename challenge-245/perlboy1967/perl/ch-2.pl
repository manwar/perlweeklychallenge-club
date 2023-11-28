#!/bin/perl

=pod

The Weekly Challenge - 245
- https://theweeklychallenge.org/blog/perl-weekly-challenge-245

Author: Niels 'PerlBoy' van Dijke

Task 2: Largest of Three
Submitted by: Mohammad S Anwar

You are given an array of integers >= 0.

Write a script to return the largest number formed by concatenating some of the given
integers in any order which is also multiple of 3. Return -1 if none found.

=cut

use v5.32;
use common::sense;

use Test2::V0;

use Algorithm::Combinatorics qw(permutations subsets);

sub largestOfThree (@) {
  my @l = sort { $b <=> $a } @_;

  my $subsetSize = $#l+1;
  while ($subsetSize > 0) {
    for my $subset (subsets(\@l,$subsetSize)) {
      my @subset = sort { $b <=> $a } @$subset;
      for my $p (permutations(\@subset)) {
        my $s = join('',@$p);
        return $s if ($s % 3 == 0);
      }
      $subsetSize--;
    }
  }
  return -1;
}


is(largestOfThree(8,1,9),981);
is(largestOfThree(8,6,7,1,0),8760);
is(largestOfThree(1),-1);

done_testing;
