#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(binaryprefix([0, 1, 1, 0, 0, 1, 0, 1, 1, 1]), [1, 0, 0, 0, 0, 1, 1, 0, 0, 0], 'example 1');
is_deeply(binaryprefix([1, 0, 1, 0, 1, 0]), [0, 0, 1, 1, 0, 0], 'example 2');
is_deeply(binaryprefix([0, 0, 1, 0, 1]), [1, 1, 0, 0, 1], 'example 3');
is_deeply(binaryprefix([1, 1, 1, 1, 1]), [0, 0, 0, 1, 0], 'example 4');
is_deeply(binaryprefix([1, 0, 1, 1, 0, 1, 0, 0, 1, 1]), [0, 0, 1, 0, 0, 1, 1, 1, 0, 0], 'example 5');

sub binaryprefix($a) {
  my $c = 0;
  my @out;
  foreach my $n (@{$a}) {
    $c *= 2;
    $c += $n;
    push @out, ($c % 5 == 0)?1:0;
  }
  \@out;
}
