#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(magicnumber([3, 7, 5], [9, 5, 7]), 2, 'example 1');
is(magicnumber([1, 2, 1], [5, 4, 4]), 3, 'example 2');
is(magicnumber([2], [5]), 3, 'example 3');

use List::Util qw(min);

sub magicnumber($a, $b) {
  return min(@{$b}) - min(@{$a});
}
