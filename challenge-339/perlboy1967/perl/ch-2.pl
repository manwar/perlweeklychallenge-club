#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-339#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Peak Point
Submitted by: Mohammad Sajid Anwar

You are given an array of altitude gain.

Write a script to find the peak point gained.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(max);
use List::MoreUtils qw(slide);

sub peakPoint (@numbers) {
  my $i = 0;
  max map { $i += $_ } @numbers;
}

is(peakPoint(-5,1,5,-9,2),1,'Example 1');
is(peakPoint(10,10,10,-25),30,'Example 2');
is(peakPoint(3,-4,2,5,-6,1),6,'Example 3');
is(peakPoint(-1,-2,-3,-4),-1,'Example 4');
is(peakPoint(-10,15,5),10,'Example 5');

done_testing;
