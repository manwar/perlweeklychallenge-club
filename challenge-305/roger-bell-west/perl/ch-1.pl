#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(binaryprefix([1, 0, 1]), [0, 1, 1], 'example 1');
is_deeply(binaryprefix([1, 1, 0]), [0, 1, 0], 'example 2');
is_deeply(binaryprefix([1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1]), [0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], 'example 3');

use Math::Prime::Util qw(is_prime);

sub binaryprefix($a) {
  my @out;
  my $n = 0;
  foreach my $x (@{$a}) {
    $n *= 2;
    if ($x == 1) {
      $n++;
    }
    push @out, is_prime($n)?1:0;
  }
  \@out;
}
