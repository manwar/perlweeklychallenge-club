#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(maximumpairs(['ab', 'de', 'ed', 'bc']), 1, 'example 1');
is(maximumpairs(['aa', 'ba', 'cd', 'ed']), 0, 'example 2');
is(maximumpairs(['uv', 'qp', 'st', 'vu', 'mn', 'pq']), 2, 'example 3');

sub maximumpairs($a) {
  my $n = 0;
  my %r;
  foreach my $s (@{$a}) {
    my $t = reverse($s);
    if (exists $r{$t}) {
      $n++;
    } else {
      $r{$s} = 1;
    }
  }
  return $n;
}
