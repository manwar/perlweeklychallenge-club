#!/bin/perl

=pod

The Weekly Challenge - 310
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-310#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Sort Odd Even
Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to sort odd index elements in decreasing order and even
index elements in increasing order in the given array.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

sub sortOddEven (@ints) {
  my (@l1,@l2);

  map { push(@{$l1[$_ % 2]}, $ints[$_]) } 0 .. $#ints;

  $l1[0] = [sort { $a <=> $b } @{$l1[0]}];
  $l1[1] = [sort { $b <=> $a } @{$l1[1]}];

  for (0 .. $#{$l1[0]}) {
    push(@l2,$l1[0][$_]);
    push(@l2,$l1[1][$_]) if defined $l1[1][$_];
  }

  return @l2;
}

is([sortOddEven(4,1,2,3)],
   [2,3,4,1],'Example 1');
is([sortOddEven(3,1)],
   [3,1],'Example 2');
is([sortOddEven(5,3,2,1,4)],
   [2,3,4,1,5],'Example 3');

done_testing;
