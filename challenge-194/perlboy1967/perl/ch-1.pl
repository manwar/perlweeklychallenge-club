#!/bin/perl

=pod

The Weekly Challenge - 194
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-194/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Digital Clock
Submitted by: Mohammad S Anwar

You are given time in the format hh:mm with one missing digit.

Write a script to find the highest digit between 0-9 that makes it valid time.

=cut

use v5.16;
use warnings;

use Test::More;


sub highestDigit ($) {
  state $c = { 0=>2, 1=>9, 2=>-1, 3=>5, 4=>9 };

  (length($_[0]) == 5 && $_[0] =~ y/?/?/) == 1 ? $c->{index($_[0],'?')} // -1 : -1;
}


my %t = qw(?0:00 2 1?:00 9 10:?2 5 12:1? 9 ??:00 -1 00?00 -1 00:00? -1 ?00:00 -1);

for (sort keys %t) {
 is(highestDigit($_),$t{$_},"highestDigit('$_')");
}

done_testing;
