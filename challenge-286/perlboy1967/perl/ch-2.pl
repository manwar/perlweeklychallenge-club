#!/bin/perl

=pod

The Weekly Challenge - 286
- L<https://theweeklychallenge.org/blog/perl-weekly-challenge-286>

Author: Niels 'PerlBoy' van Dijke

Task 2: Order Game
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, whose length is a power of 2.

Write a script to play the order game (min and max) and return the last element.

=cut

use v5.32;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

use DDP;
use List::AllUtils qw(min max natatime);

sub orderGame (@ints) {
  while (scalar @ints > 2) {
    my @i;
    push(@i,min(splice(@ints,0,2)),max(splice(@ints,0,2))) while (@ints);
    @ints = @i;
  }
  min(@ints);
}

is(1,orderGame(2,1,4,5,6,3,0,2));
is(0,orderGame(0,5,3,2));
is(2,orderGame(9,2,1,4,5,6,0,7,3,1,3,5,7,9,0,8));

done_testing;
