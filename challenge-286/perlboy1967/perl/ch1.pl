#!/bin/perl

=pod

The Weekly Challenge - 286
- L<https://theweeklychallenge.org/blog/perl-weekly-challenge-286>

Author: Niels 'PerlBoy' van Dijke

Task 1: Self Spammer
Submitted by: David Ferrone

Write a program which outputs one word of its own script / source code at random. 
A word is anything between whitespace, including symbols.

=cut

use v5.32;
use feature qw(signatures);
no warnings qw(experimental::signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

use File::Slurp;

sub selfSpammer {
  my @w = grep /\S/, split /\s/, read_file(__FILE__);
  $w[rand @w];
}

srand(0);

is(selfSpammer,'Dijke');

done_testing;
