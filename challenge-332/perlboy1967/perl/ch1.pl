#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-332#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Binary Date
Submitted by: Mohammad Sajid Anwar

You are given a date in the format YYYY-MM-DD.

Write a script to convert it into binary date.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub binaryDate ($date) {
  $date =~ s/(\d+)(\D+)(\d+)(\D+)(\d+)/sprintf("%b$2%b$4%b",$1,$3,$5)/er;
}

is(binaryDate('2025-07-26'),'11111101001-111-11010','Example 1');
is(binaryDate('2000-02-02'),'11111010000-10-10','Example 2');
is(binaryDate('2024-12-31'),'11111101000-1100-11111','Example 3');

done_testing;
