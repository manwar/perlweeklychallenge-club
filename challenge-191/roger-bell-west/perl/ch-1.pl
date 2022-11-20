#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(twicelargest(1, 2, 3, 4), 0, 'example 1');
is(twicelargest(1, 2, 0, 5), 1, 'example 2');
is(twicelargest(2, 6, 3, 1), 1, 'example 3');
is(twicelargest(4, 5, 2, 3), 0, 'example 4');

sub twicelargest(@l0) {
  my @l = sort @l0;
  return ($l[-1] >= 2*$l[-2])?1:0;
}
