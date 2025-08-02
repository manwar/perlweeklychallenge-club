#!/bin/perl

=pod

The Weekly Challenge - 312
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-312#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Balls and Boxes
Submitted by: Mohammad Sajid Anwar

There are $n balls of mixed colors: red, blue or green. They are all distributed in 10 boxes labelled 0-9.

You are given a string describing the location of balls.

Write a script to find the number of boxes containing all three colors. Return 0 if none found.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

sub ballsAndBoxes ($str) {
  my %b;
  state $m = {R => 4, G => 2, B => 1};
  while ($str =~ m#([RGB])(\d+)#g) {
    $b{$2} //= 0; $b{$2} |= $m->{$1};
  }
  return scalar grep { $b{$_} == 7 } keys %b;
}

is(ballsAndBoxes('G0B1R2R0B0'),1,'Example 1');
is(ballsAndBoxes('G1R3R6B3G6B1B6R1G3'),3,'Example 2');
is(ballsAndBoxes('B3B2G1B3'),0,'Example 3');

done_testing;
