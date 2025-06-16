#!/bin/perl

=pod

The Weekly Challenge - 326
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-326#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Decompressed List
Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers having even elements.

Write a script to to return the decompress list. To decompress, pick
adjacent pair (i, j) and replace it with j, i times.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(pairmap);

sub decompress (@c) {
  pairmap { ($b) x $a } @c;
}

is([decompress(1,3,2,4)],[3,4,4],'Example 1');
is([decompress(1,1,2,2)],[1,2,2],'Example 2');
is([decompress(3,1,3,2)],[1,1,1,2,2,2],'Example 3');

done_testing;
