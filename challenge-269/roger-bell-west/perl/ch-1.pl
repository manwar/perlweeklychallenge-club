#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(bitwiseor([1, 2, 3, 4, 5]), 1, 'example 1');
is(bitwiseor([2, 3, 8, 16]), 1, 'example 2');
is(bitwiseor([1, 2, 5, 7, 9]), 0, 'example 3');

sub bitwiseor($a) {
  return (scalar grep {$_ % 2 == 0} @{$a}) >= 2 ? 1 : 0;
}
