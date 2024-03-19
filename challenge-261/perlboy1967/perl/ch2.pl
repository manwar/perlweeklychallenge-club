#!/bin/perl

=pod

The Weekly Challenge - 261
- https://theweeklychallenge.org/blog/perl-weekly-challenge-261

Author: Niels 'PerlBoy' van Dijke

Task 2: Multiply by Two
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer $start..

Write a script to do the followings:

a) Look for $start in the array @ints, if found multiply the number by 2
b) If not found stop the process otherwise repeat

In the end return the final value.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(sum);

sub multiplyByTwo ($i,@ints) {
  my %i = map { ($_,1) } @ints; 
  $i *= 2 while (exists $i{$i});
  return $i;
}

is(multiplyByTwo(3,5,3,6,1,12),24);
is(multiplyByTwo(1,1,2,4,3),8);
is(multiplyByTwo(2,5,6,7),2);

done_testing;
