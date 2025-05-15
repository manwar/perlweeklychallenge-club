#!/bin/perl

=pod

The Weekly Challenge - 320
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-320#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Maximum Count
Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the maximum between the number of positive and
negative integers. Zero is neither positive nor negative.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use List::AllUtils qw(max);

sub maximumCount (@ints) {
  my %c;
  $c{$_ <=> 0}++ for (@ints);
  delete $c{0};
  return max(values %c);
}

is(3,maximumCount(-3,-2,-1,1,2,3),'Example 1');
is(2,maximumCount(-2,-1,0,0,1),'Example 2');
is(4,maximumCount(1,2,3,4),'Example 3');

done_testing;
