#!/bin/perl

=pod

The Weekly Challenge - 303
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-308#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Count Common
Submitted by: Mohammad Sajid Anwar

You are given two array of strings, @str1 and @str2.

Write a script to return the count of common strings in both arrays.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

no warnings qw(experimental::signatures);

sub countCommon :prototype(\@\@) ($ar1,$ar2) {
  my (%f1,%f2,%f3);
  map { $f1{$_} = 1 } @$ar1;
  map { $f2{$_} = 1 } @$ar2;
  map { $f3{$_}++ } keys %f1, keys %f2;
  scalar grep { $f3{$_} == 2 } keys %f3;
}

is(countCommon(@{[qw(perl weekly challenge)]},
               @{[qw(raku weekly challenge)]}),
                2,'Example 1');
is(countCommon(@{[qw(perl raku python)]},
               @{[qw(python java)]}),
                1,'Example 2');
is(countCommon(@{[qw(guest contribution)]},
               @{[qw(fun weekly challenge)]}),
                0,'Example 3');
is(countCommon(@{[1,2,2,3]},@{[2,3,3,4]}),2,'Own test');

done_testing;
