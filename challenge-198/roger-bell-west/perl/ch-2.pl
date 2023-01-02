#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Math::Prime::Util qw(primes);

use Test::More tests => 4;

is(primecount(10), 4, 'example 1');
is(primecount(15), 6, 'example 2');
is(primecount(1), 0, 'example 3');
is(primecount(25), 9, 'example 4');

sub primecount($l) {
  return scalar @{primes($l-1)};
}
