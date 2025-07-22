#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(lastword('The Weekly Challenge'), 9, 'example 1');
is(lastword('   Hello   World    '), 5, 'example 2');
is(lastword("Let's begin the fun"), 3, 'example 3');

sub lastword($a) {
  my @w = grep {length($a) > 0} split ' ', $a;
  length($w[-1]);
}
