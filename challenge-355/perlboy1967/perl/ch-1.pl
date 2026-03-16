#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-355#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Thousand Separator
Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int.

Write a script to add thousand separator, , and return as string.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub thousandSeperator ($i) {
  join ',', reverse map { scalar reverse $_ } unpack '(A3)*', reverse $i;
}


is(thousandSeperator(123),123,'Example 1');
is(thousandSeperator(1234),'1,234','Example 2');
is(thousandSeperator(1000000),'1,000,000','Example 3');
is(thousandSeperator(1),1,'Example 4');
is(thousandSeperator(12345),'12,345','Example 5');

done_testing;
