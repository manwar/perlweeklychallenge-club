#!/bin/perl

=pod

The Weekly Challenge - 246
- https://theweeklychallenge.org/blog/perl-weekly-challenge-246

Author: Niels 'PerlBoy' van Dijke

Task 1: 6 out of 49
Submitted by: Andreas Voegele

6 out of 49 is a German lottery.

Write a script that outputs six unique random integers from the range 1 to 49.

=cut

use v5.32;
use common::sense;

use Test2::V0 -srand => 246;

sub germanLottery () {
  my @balls = (1..49);
  sort { $a <=> $b } map { splice(@balls,rand $#balls + 1,1) } 1..6;
}

is([germanLottery],[4,19,20,34,38,46]);

done_testing;
