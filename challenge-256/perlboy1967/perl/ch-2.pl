#!/bin/perl

=pod

The Weekly Challenge - 256
- https://theweeklychallenge.org/blog/perl-weekly-challenge-256

Author: Niels 'PerlBoy' van Dijke

Task 2: Merge Strings
Submitted by: Mohammad Sajid Anwar

You are given two strings, $str1 and $str2.

Write a script to merge the given strings by adding in alternative order
starting with the first string. If a string is longer than the other then
append the remaining at the end.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::MoreUtils qw(pairwise);

sub mergeStrings ($s1,$s2) {
  my @s1 = split //, $s1; my @s2 = split //, $s2;
  join '', pairwise { ($a//'').($b//'') } @s1, @s2;
}

is(mergeStrings('abcd','1234'),'a1b2c3d4');
is(mergeStrings('abc','12345'),'a1b2c345');
is(mergeStrings('abcde','123'),'a1b2c3de');

done_testing;
