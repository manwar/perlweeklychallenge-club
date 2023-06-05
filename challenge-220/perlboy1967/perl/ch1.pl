#!/bin/perl

=pod

The Weekly Challenge - 220
- https://theweeklychallenge.org/blog/perl-weekly-challenge-220

Author: Niels 'PerlBoy' van Dijke

Task 1: Common Characters
Submitted by: Mohammad S Anwar

You are given a list of words.

Write a script to return the list of common characters (sorted alphabeticall)
found in every word of the given list.

=cut

use v5.16;

use common::sense;

use Test::More;
use Test::Deep qw(cmp_deeply);

use List::MoreUtils qw(uniq);

sub commonChars (@) {
  my %c;
  map { $c{$_}++ } uniq split //,lc for (@_);
  sort grep { $c{$_} >= scalar @_ } keys %c;
}

cmp_deeply([commonChars(qw(Perl Rust Raku))],[qw(r)]);
cmp_deeply([commonChars(qw(love live leave))],[qw(e l v)]);
cmp_deeply([commonChars(qw(bamboo bank))],[qw(a b)]);

done_testing;
