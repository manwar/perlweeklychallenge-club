#!/usr/bin/perl

use strict;
use warnings;

use feature 'say';

my (@in) = grep { ! /\D/ } @ARGV;
die "Give me exactly two integers\n" unless @in == 2;

my %factors;

for my $x (@in) {
  for my $y (1 .. $x) {
    $factors{$y}++ unless $x % $y;
  }
}

say '(', join(', ', grep { $factors{$_} == 2 } sort keys %factors), ')';
