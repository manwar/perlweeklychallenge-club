#!/bin/perl

=pod

The Weekly Challenge - 215
- https://theweeklychallenge.org/blog/perl-weekly-challenge-215

Task 2: Number Placement
Submitted by: Mohammad S Anwar

You are given a list of numbers having just 0 and 1. You are also given placement count (>=1).

Write a script to find out if it is possible to replace 0 with 1 in the given list. The only
condition is that you can only replace when there is no 1 on either side. Print 1 if it is
possible otherwise 0.

=cut

use v5.16;

use common::sense;

use Test::More;

sub numberPlacement ($@) {
  my ($n,$s) = (shift @_,join '',@_);
  
  while ($n and $s =~ m#000#g) { $n--; pos($s)-- }

  $n == 0 ? 1 : 0;
}

is(numberPlacement(1,1,0,0,0,1),1);
is(numberPlacement(2,1,0,0,0,1),0);
is(numberPlacement(3,1,0,0,0,0,0,0,0,1),1);
is(numberPlacement(0),1);
is(numberPlacement(1),0);
is(numberPlacement(1,0),0);
is(numberPlacement(1,0,0),0);
is(numberPlacement(1,0,0,0),1);

done_testing;
