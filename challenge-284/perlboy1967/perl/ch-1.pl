#!/bin/perl

=pod

The Weekly Challenge - 284
- L<https://theweeklychallenge.org/blog/perl-weekly-challenge-284>

Author: Niels 'PerlBoy' van Dijke

Task 1: Lucky Integer
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the lucky integer if found otherwise return -1. If there are more
than one then return the largest.

|| A lucky integer is an integer that has a frequency in the array equal to its value.

=cut

use v5.32;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

use List::Util qw(max);

sub luckyInteger (@ints) {
  my %f; $f{$_}++ for (@ints);
  max(-1,grep { $f{$_} == $_ } keys %f);
}

is(luckyInteger(2,2,3,4),2,'Example 1');
is(luckyInteger(1,2,2,3,3,3),3,'Example 2');
is(luckyInteger(1,1,1,3),-1,'Example 3');

done_testing;
