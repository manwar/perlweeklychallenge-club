#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;
use Algorithm::Combinatorics qw(combinations);

is(unequaltriplets([4, 4, 2, 4, 3]), 3, 'example 1');
is(unequaltriplets([1, 1, 1, 1, 1]), 0, 'example 2');
is(unequaltriplets([4, 7, 1, 10, 7, 4, 1, 1]), 28, 'example 3');

sub unequaltriplets($utl) {
  my %utc;
  foreach my $n (@{$utl}) {
    $utc{$n}++;
  }
  my @kl = keys %utc;
  if (scalar @kl < 3) {
    return 0;
  }
  my $out = 0;
  foreach my $c (combinations(\@kl, 3)) {
    $out += $utc{$c->[0]} * $utc{$c->[1]} * $utc{$c->[2]};
  }
  return $out;
}
