#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(decodexor([1, 2, 3], 1), [1, 0, 2, 1], 'example 1');
is_deeply(decodexor([6, 2, 7, 3], 4), [4, 2, 0, 7, 4], 'example 2');

sub decodexor($a, $init) {
  my @out = ($init);
  foreach my $v (@{$a}) {
    push @out, $out[-1] ^ $v;
  }
  \@out;
}
