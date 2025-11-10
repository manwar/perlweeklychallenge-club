#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-345#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Peak Positions
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Find all the peaks in the array, a peak is an element that is strictly
greater than its left and right neighbours. Return the indices of all such
peak positions.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub peakPositions (@ints) {
  map { $ints[$_-1] < $ints[$_] > $ints[$_+1] ? $_ : () } 1 .. $#ints - 1;
}

is([peakPositions(1,3,2)],[1],'Example 1');
is([peakPositions(2,4,6,5,3)],[2],'Example 2');
is([peakPositions(1,2,3,2,4,1)],[2,4],'Example 3');
is([peakPositions(5,3,1)],[],'Example 4');
is([peakPositions(1,5,1,5,1,5,1)],[1,3,5],'Example 5');

done_testing;
