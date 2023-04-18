#!/bin/perl

=pod

The Weekly Challenge - 213
- https://theweeklychallenge.org/blog/perl-weekly-challenge-213

Author: Niels 'PerlBoy' van Dijke

Task 1: Fun Sort
Submitted by: Mohammad S Anwar

You are given a list of positive integers.

Write a script to sort the all even integers first then all odds in ascending order.

=cut

use v5.16;

use common::sense;

use Test::More;
use Test::Deep qw(cmp_deeply);

sub evenOddSort {
  sort { (($a & 1) <=> ($b & 1)) || ($a <=> $b) } @_;
}

cmp_deeply([evenOddSort(1,2,3,4,5,6)],[2,4,6,1,3,5]);
cmp_deeply([evenOddSort(1,2)],[2,1]);
cmp_deeply([evenOddSort(1)],[1]);

done_testing;
