#!/bin/perl

=pod

The Weekly Challenge - 278
- https://theweeklychallenge.org/blog/perl-weekly-challenge-278

Author: Niels 'PerlBoy' van Dijke

Task 1: Sort String
Submitted by: Mohammad Sajid Anwar

You are given a shuffle string, $str.

Write a script to return the sorted string.

|| A string is shuffled by appending word position to each word.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0 qw(-no_srand);

sub sortString ($str) {
  join ' ',map {$_->[0]} sort {$$a[1]<=>$$b[1]} map {[/(\D+)(\d+)/]} split /\s+/,$str
}

is(sortString('and2 Raku3 cousins5 Perl1 are4'),
              'Perl and Raku are cousins');
is(sortString('guest6 Python1 most4 the3 popular5 is2 language7'),
              'Python is the most popular guest language');
is(sortString('Challenge3 The1 Weekly2'),
              'The Weekly Challenge');

done_testing;
