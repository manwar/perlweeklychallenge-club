#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Math::Prime::Util qw(primes);

use Test::More tests => 3;

is(countprimes(10), 4, 'example 1');
is(countprimes(1), 0, 'example 2');
is(countprimes(20), 8, 'example 3');

sub countprimes($l) {
  return scalar @{primes($l)};
}
