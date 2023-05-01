#!/bin/perl

=pod

The Weekly Challenge - 215
- https://theweeklychallenge.org/blog/perl-weekly-challenge-215

Author: Niels 'PerlBoy' van Dijke

Task 1: Odd one Out
Submitted by: Mohammad S Anwar

You are given a list of words (alphabetic characters only) of same size.

Write a script to remove all words not sorted alphabetically and print the number
of words in the list that are not alphabetically sorted.

=cut

use v5.16;

use common::sense;

use Test::More;

sub oddOneOut {
  grep { $_ ne join '',sort split //,$_ } @_;
}

is(oddOneOut('abc','xyz','tsu'),1);
is(oddOneOut('rat','cab','dad'),3);
is(oddOneOut('x','y','z'),0);
is(oddOneOut('cd','add','loop'),0);

done_testing;
