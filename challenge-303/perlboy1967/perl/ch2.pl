#!/bin/perl

=pod

The Weekly Challenge - 303
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-303#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Delete and Earn
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return the maximum number of points you can earn by applying the
following operation some number of times.

|| Pick any ints[i] and delete it to earn ints[i] points.
|| Afterwards, you must delete every element equal to ints[i] - 1
|| and every element equal to ints[i] + 1.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

use List::Util qw(max);

no warnings qw(experimental::signatures);
sub deleteAndEarn (@ints) {
  my %c; map $c{$_}++,@ints;
  my $m = max(keys %c);

  my @d = (0) x ($m + 1);

  for my $n (0 .. $m) {
    $d[$n] = $n == 0 ? 0 : 
             $n == 1 ? $d[$n] = $c{$n} // 0 : 
             max($d[$n-1], $d[$n-2] + $n * ($c{$n} // 0));
  }

  return $d[$m];
}

is(deleteAndEarn(3,4,2),6,'Example 1');
is(deleteAndEarn(2,2,3,3,3,4),9,'Example 2');

done_testing;
