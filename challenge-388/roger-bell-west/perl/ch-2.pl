#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(secretsanta(1), 0, 'example 1');
is(secretsanta(2), 1, 'example 2');
is(secretsanta(3), 2, 'example 3');
is(secretsanta(4), 9, 'example 4');
is(secretsanta(5), 44, 'example 5');

sub secretsanta($n) {
  if ($n == 0) {
    return 1;
  }
  if ($n == 1) {
    return 0;
  }
  return ($n - 1) * (secretsanta($n - 1) + secretsanta($n - 2));
}
