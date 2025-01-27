#!/bin/perl

=pod

The Weekly Challenge - 305
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-305#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Odd Sum
Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to return the sum of all possible odd-length subarrays of
the given array. A subarray is a contiguous subsequence of the array.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

no warnings qw(experimental::signatures);

use List::Util qw(sum);

sub oddSum (@ints) {
  my ($sum,$i) = (0,1);
  while ($i <= scalar @ints) {
    for my $j (0 .. scalar(@ints)-$i) {
      $sum += sum(@ints[$j..$j+$i-1])
    }
    $i += 2;
  }
  return $sum;
}

is(oddSum(2,5,3,6,4),77,'Example 1');
is(oddSum(1,3),4,'Example 2');

done_testing;
