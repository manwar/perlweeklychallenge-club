#!/bin/perl

=pod

The Weekly Challenge - 255
- https://theweeklychallenge.org/blog/perl-weekly-challenge-255

Author: Niels 'PerlBoy' van Dijke

Task 2: Most Frequent Word
Submitted by: Mohammad Sajid Anwar

You are given a paragraph $p and a banned word $w.

Write a script to return the most frequent word that is not banned.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::Util qw(max);
use List::MoreUtils qw(frequency);

sub almostFrequentWord ($p,$ban) {
  my %f = frequency grep !/$ban/, split /\W+/, $p;
  my %w; push(@{$w{$f{$_}}},$_) for (keys %f);
  $w{max(keys %w)};
}

is(almostFrequentWord('five dot three dot three','dot'),['three']);
is(almostFrequentWord('one plus one plus one equals three','one'),['plus']);

done_testing;

