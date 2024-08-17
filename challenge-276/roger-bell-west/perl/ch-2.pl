#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(maximumfrequency([1, 2, 2, 4, 1, 5]), 4, 'example 1');
is(maximumfrequency([1, 2, 3, 4, 5]), 5, 'example 2');

use List::Util qw(max);

sub maximumfrequency($a) {
  my %c;
  foreach my $n (@{$a}) {
    $c{$n}++;
  }
  my $m = max(values %c);
  return $m * scalar grep {$_ == $m} values %c;
}
