#!/bin/perl

=pod

The Weekly Challenge - 279
- https://theweeklychallenge.org/blog/perl-weekly-challenge-279

Author: Niels 'PerlBoy' van Dijke

Task 1: Sort Letters
Submitted by: Mohammad Sajid Anwar

You are given two arrays, @letters and @weights.

Write a script to sort the given array @letters based on the @weights.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

sub sortLetters :prototype(\@\@) ($arL,$arW) { 
  my $i = 0;
  join '', map {$$_[0]} sort { $$a[1]<=>$$b[1] } map {[$_,$$arW[$i++]]} @$arL;
}

is(sortLetters(@{[qw{R E P L}]},@{[qw{3 2 1 4}]}),'PERL','Example 1');
is(sortLetters(@{[qw{A U R K}]},@{[qw{2 4 1 3}]}),'RAKU','Example 2');
is(sortLetters(@{[qw{O H Y N P T}]},@{[qw{5 4 2 6 1 3}]}),'PYTHON','Example 3');

done_testing;
