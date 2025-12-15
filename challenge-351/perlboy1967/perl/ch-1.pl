#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-351#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Special Average
Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the average excluding the minimum and maximum of the given array.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(sum);
use List::MoreUtils qw(minmax);

sub specialAverage (@ints) {
  return 0 unless @ints;
  my @m = minmax(@ints);
  my @i = grep { $_ != $m[0] and $_ != $m[1] } @ints;
  return @i ? sum(@i)/@i : 0;
}

is(specialAverage(8000,5000,6000,2000,3000,7000),5250,'Example 1');
is(specialAverage(100_000,80_000,110_000,90_000),95_000,'Example 2');
is(specialAverage(2500,2500,2500,2500),0,'Example 3');
is(specialAverage(2000),0,'Example 4');
is(specialAverage(1000,2000,3000,4000,5000,6000),3500,'Example 5');
is(specialAverage(10,10,30,30),0,'Own Example 1');
is(specialAverage(-2,-1,0,1,2),0,'Own Example 2');

done_testing;
