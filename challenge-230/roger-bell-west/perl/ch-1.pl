#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(separatedigits([1, 34, 5, 6]), [1, 3, 4, 5, 6], 'example 1');
is_deeply(separatedigits([1, 24, 51, 60]), [1, 2, 4, 5, 1, 6, 0], 'example 2');

sub separatedigits($a) {
  my @out;
  foreach my $n (@{$a}) {
    my $m = $n;
    my @v;
    while ($m > 0) {
      push @v, $m % 10;
      $m = int($m / 10);
    }
    push @out, reverse @v;
  }
  return \@out;
}
