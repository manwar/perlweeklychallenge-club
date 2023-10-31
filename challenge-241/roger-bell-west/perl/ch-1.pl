#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(arithmetictriplets([0, 1, 4, 6, 7, 10], 3), 2, 'example 1');
is(arithmetictriplets([4, 5, 6, 7, 8, 9], 2), 2, 'example 2');

sub arithmetictriplets($a, $diff) {
  my %vs = map {$_ => 1} @{$a};
  return grep {(exists $vs{$_+$diff}) && (exists $vs{$_+$diff*2})} @{$a};
}
