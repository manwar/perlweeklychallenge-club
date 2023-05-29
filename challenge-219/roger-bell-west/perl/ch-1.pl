#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(sortedsquares([-2, -1, 0, 3, 4]), [0, 1, 4, 9, 16], 'example 1');
is_deeply(sortedsquares([5, -4, -1, 3, 6]), [1, 9, 16, 25, 36], 'example 2');

sub sortedsquares($lst) {
  return [sort {$a <=> $b} map{$_ * $_} @{$lst}];
}
