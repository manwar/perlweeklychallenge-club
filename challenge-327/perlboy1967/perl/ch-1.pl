#!/bin/perl

=pod

The Weekly Challenge - 327
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-327#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Missing Integers
Submitted by: Mohammad Sajid Anwar

You are given an array of n integers.

Write a script to find all the missing integers in the range 1..n in the given array.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::MoreUtils qw(indexes);

sub missingIntegers (@ints) {
  my @i = (0) x @ints;
  $i[$_ - 1]++ for (@ints);
  map { $_ + 1 } indexes { $_ == 0 } @i;
}

is([missingIntegers(1,2,1,3,2,5)],[4,6],'Example 1');
is([missingIntegers(1,1,1)],[2,3],'Example 2');
is([missingIntegers(2,2,1)],[3],'Example 3');

done_testing;
