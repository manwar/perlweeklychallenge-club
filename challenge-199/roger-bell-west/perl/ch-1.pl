#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(goodpairs([1, 2, 3, 1, 1, 3]), 4, 'example 1');
is(goodpairs([1, 2, 3]), 0, 'example 2');
is(goodpairs([1, 1, 1, 1]), 6, 'example 3');

sub goodpairs($l) {
  my $c = 0;
  my %k;
  map {$k{$_}++} @{$l};
  foreach my $v (values %k) {
    $c += $v * ($v-1);
  }
  return $c / 2;
}
