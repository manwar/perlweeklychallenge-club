#!/bin/perl

=pod

The Weekly Challenge - 258
- https://theweeklychallenge.org/blog/perl-weekly-challenge-258

Author: Niels 'PerlBoy' van Dijke

Task 1: Count Even Digits Number
Submitted by: Mohammad Sajid Anwar

You are given a array of positive integers, @ints.

Write a script to find out how many integers have even number of digits.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

sub evenDigits (@ints) {
  scalar grep { /^\d+$/ and (length $_) % 2 == 0 } @ints;
}

is(evenDigits(10,1,111,24,1000),3);
is(evenDigits(111,1,11111),0);
is(evenDigits(2,8,1024,256),1);
is(evenDigits(20,'Perl',1234),2);

done_testing;
