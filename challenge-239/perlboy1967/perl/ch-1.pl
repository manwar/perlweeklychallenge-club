#!/bin/perl

=pod

The Weekly Challenge - 239
- https://theweeklychallenge.org/blog/perl-weekly-challenge-239

Author: Niels 'PerlBoy' van Dijke

Task 1: Same String
Submitted by: Mohammad S Anwar

You are given two arrays of strings.

Write a script to find out if the word created by concatenating the array
elements is the same.

=cut

use v5.32;
use common::sense;

use Test2::V0;

sub sameString (\@\@) {
  join('',@{$_[0]}) eq join('',@{$_[1]}) ? 1 : 0;
}

is(sameString(@{[qw(ab c)]},@{[qw(a bc)]}),1);
is(sameString(@{[qw(ab c)]},@{[qw(ac b)]}),0);
is(sameString(@{[qw(ab cd e)]},@{[qw(abcde)]}),1);

done_testing;
