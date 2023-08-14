#!/bin/perl

=pod

The Weekly Challenge - 229
- https://theweeklychallenge.org/blog/perl-weekly-challenge-229

Author: Niels 'PerlBoy' van Dijke

Task 1: Lexicographic Order
Submitted by: Mohammad S Anwar

You are given an array of strings.

Write a script to delete element which is not lexicographically sorted 
(forwards or backwards) and return the count of deletions.

=cut


use v5.16;

use common::sense;

use Test::More;

sub lexicographicOrder (@) {
  return scalar grep {
    my @c = sort split //, $_;
    (join('',@c) ne $_ and join('',reverse @c) ne $_) ? 1 : 0;
  } @_;
}

is(lexicographicOrder(qw(abc bce cae)),1);
is(lexicographicOrder(qw(yxz cba mon)),2);

done_testing;
