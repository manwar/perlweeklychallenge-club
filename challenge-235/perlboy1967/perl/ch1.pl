#!/bin/perl

=pod

The Weekly Challenge - 235
- https://theweeklychallenge.org/blog/perl-weekly-challenge-235

Author: Niels 'PerlBoy' van Dijke

Task 1: Remove One
Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out if removing ONLY one integer makes it strictly increasing order.

=cut

use v5.16;

use common::sense;

use Test::More;

use List::MoreUtils qw(slide);

sub removeOne (@) {
  scalar(grep { $_ < 0 } slide { $b - $a } @_) <= 1 ? 1 : 0;
}

is(removeOne(0, 2, 9, 4, 6), 1);
is(removeOne(5, 1, 3, 2), 0);
is(removeOne(2, 2, 3), 1);

done_testing;

