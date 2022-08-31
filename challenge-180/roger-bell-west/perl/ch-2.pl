#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(trimlist([1, 4, 2, 3, 5], 3), [4, 5], 'example 1');
is_deeply(trimlist([9, 0, 6, 2, 3, 8, 5], 4), [9, 6, 8, 5], 'example 2');

sub trimlist($n, $i) {
  return [grep {$_ > $i} @{$n}];
}
