#!/bin/perl

=pod

The Weekly Challenge - 326
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-326#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Day of the Year
Submitted by: Mohammad Sajid Anwar

You are given a date in the format YYYY-MM-DD.

Write a script to find day number of the year that the given date represent.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use Time::Piece;

sub dayOfTheYear ($date) {
  Time::Piece->strptime($date, '%Y-%m-%d')->yday + 1
}

is(dayOfTheYear('2025-02-02'),33,'Example 1');
is(dayOfTheYear('2025-04-10'),100,'Example 2');
is(dayOfTheYear('2025-09-07'),250,'Example 3');

done_testing;
