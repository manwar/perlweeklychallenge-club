#!/bin/perl

=pod

The Weekly Challenge - 277
- https://theweeklychallenge.org/blog/perl-weekly-challenge-277

Author: Niels 'PerlBoy' van Dijke

Task 1: Count Common
Submitted by: Mohammad Sajid Anwar

You are given two array of strings, @words1 and @words2.

Write a script to return the count of words that appears in both
arrays exactly once.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

sub countCommon {
  my ($arW1,$arW2,%f1,%f2,%fc) = @_;
  map { $f1{$_}++ } @$arW1;
  map { $f2{$_}++ } @$arW2;
  map { $fc{$_}++ } 
    (grep { $f1{$_} == 1 } keys %f1), 
    (grep { $f2{$_} == 1 } keys %f2);
  scalar grep { $_ == 2 } values %fc;
}

is(countCommon([qw{Perl is my friend}],
               [qw{Perl and Raku are friend}]),2);
is(countCommon([qw{Perl and Python are very similar}],
               [qw{Python is top in guest languages}]),1);
is(countCommon([qw{Perl is imperative Lisp is functional}],
               [qw{Crystal is similar to Ruby}]),0);

done_testing;
