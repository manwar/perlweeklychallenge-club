#!/bin/perl

=pod

The Weekly Challenge - 273
- https://theweeklychallenge.org/blog/perl-weekly-challenge-273

Author: Niels 'PerlBoy' van Dijke

Task 2: B After A
Submitted by: Mohammad Sajid Anwar

You are given a string, $str.

Write a script to return true if there is at least one 'b', and
no 'a' appears after the first 'b'.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Data::Printer;

use Test2::V0;

sub bAfterA ($str) {
  0 + ($str =~ m#^[^b]*b[^a]*$#);
}

is(bAfterA('aabb'),1,'Example 1 (aabb)');
is(bAfterA('abab'),0,'Example 2 (abab)');
is(bAfterA('aaa'),0,'Example 3 (aaa)');
is(bAfterA('bbb'),1,'Example 3 (bbb)');

done_testing;
