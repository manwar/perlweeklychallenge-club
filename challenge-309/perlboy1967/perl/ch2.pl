#!/bin/perl

=pod

The Weekly Challenge - 309
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-309#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Min Diff
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find the minimum difference between any two elements.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

no warnings qw(experimental::signatures);

use List::MoreUtils qw(slide);

sub minDiff (@ints) {
  my $min;

  slide {
    my $d = abs($a - $b);
    $min = $d if (!defined $min or $min > $d);
  } sort { $a <=> $b } @ints;

  return $min;
}

is(minDiff(1,5,8,9),1,'Example 1');
is(minDiff(9,4,1,7),2,'Example 2');

done_testing;
