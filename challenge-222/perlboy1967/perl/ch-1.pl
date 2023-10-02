#!/bin/perl

=pod

The Weekly Challenge - 222
- https://theweeklychallenge.org/blog/perl-weekly-challenge-222

Author: Niels 'PerlBoy' van Dijke

Task 1: Matching Members
Submitted by: Mohammad S Anwar

You are given a list of positive integers, @ints.

Write a script to find the total matching members after sorting the list increasing order.

=cut

use v5.16;

use common::sense;

use Test::More;
use Test::Deep qw(cmp_deeply);

use List::MoreUtils qw(pairwise);

sub matchingMembers (@) {
  pairwise { $a == $b ? $a : () } @_, @{[sort { $a <=> $b } @_]};
}

cmp_deeply([matchingMembers(1,1,4,2,1,3)],[1,1,2]);
cmp_deeply([matchingMembers(5,1,2,3,4)],[]);
cmp_deeply([matchingMembers(1,2,3,4,5)],[1,2,3,4,5]);

done_testing;
