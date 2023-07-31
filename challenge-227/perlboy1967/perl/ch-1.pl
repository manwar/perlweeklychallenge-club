#!/bin/perl

=pod

The Weekly Challenge - 227
- https://theweeklychallenge.org/blog/perl-weekly-challenge-227

Author: Niels 'PerlBoy' van Dijke

Task 1: Friday 13th
Submitted by: Peter Campbell Smith

You are given a year number in the range 1753 to 9999.

Write a script to find out how many dates in the year are Friday 13th, assume
that the current Gregorian calendar applies.

=cut

use v5.16;

use common::sense;

use Test::More;

use DateTime;

sub nFriday13th ($) {
  scalar grep { DateTime->new(year => $_[0], month => $_, day => 13)->day_of_week == 5 } (1 .. 12);
}

is(nFriday13th(2023),2);

done_testing;
