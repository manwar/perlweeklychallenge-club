#!/bin/perl

=pod

The Weekly Challenge - 324
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-324#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: 2D Array
Submitted by: Mohammad Sajid Anwar

You are given an array of integers and two integers $r amd $c.

Write a script to create two dimension array having $r rows and $c columns
using the given array.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

sub to2D ($r,$c,@ints) {
  return () if ($r * $c != scalar(@ints));
  return map { [splice(@ints,0,$c)] } 0 .. $#ints/$c;
}

is([to2D(2,2,1,2,3,4)],[[1,2],[3,4]],'Example 1');
is([to2D(1,3,1,2,3)],[[1,2,3]],'Example 2');
is([to2D(4,1,1,2,3,4)],[[1],[2],[3],[4]],'Example 3');

done_testing;
