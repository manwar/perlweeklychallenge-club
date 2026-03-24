#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-366#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Count Prefixes
Submitted by: Mohammad Sajid Anwar

You are given an array of words and a string (contains only lowercase English letters).

Write a script to return the number of words in the given array that are a prefix of the given string.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub countPrefixes ($arList,$str) {
  my $re = sprintf('^(%s)$', 
                   join('|', map { substr($str,0,$_) } 1 .. length($str)));
  return scalar grep /$re/, @$arList;
}

is(countPrefixes([qw(a ap app apple banana)],'apple'),4,
   'Example 1');
is(countPrefixes([qw(cat dog fish)],'bird'),0,
   'Example 2');
is(countPrefixes([qw(hello he hell heaven he)],'hello'),4,
   'Example 3');
is(countPrefixes(['',qw(code coding cod)],'coding'),2,
   'Example 4');
is(countPrefixes([qw(p pr pro prog progr progra program)],'program'),7,
   'Example 5');

done_testing;
