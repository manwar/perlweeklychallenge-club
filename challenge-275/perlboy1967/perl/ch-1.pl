#!/bin/perl

=pod

The Weekly Challenge - 275
- https://theweeklychallenge.org/blog/perl-weekly-challenge-275

Author: Niels 'PerlBoy' van Dijke

Task 1: Broken Keys
Submitted by: Mohammad Sajid Anwar

You are given a sentence, $sentence and list of broken keys @keys.

Write a script to find out how many words can be typed fully.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

sub brokenKeys ($sentence,@keys) {
  my $re = '['.join('',@keys).']';
  scalar grep !/$re/i, split /\s+/, $sentence;
}

is(brokenKeys('Perl Weekly Challenge','l','a'),0);
is(brokenKeys('Perl and Raku','a'),1);
is(brokenKeys('Well done Team PWC','l','o'),2);
is(brokenKeys('The joys of polyglottism','T'),2);

done_testing;
