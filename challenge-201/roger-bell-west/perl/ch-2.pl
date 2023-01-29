#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Math::Prime::Util qw(partitions);

use Test::More tests => 2;

is(pennypiles(5), 7, 'example 1');
is(pennypiles(10), 42, 'example 2');

sub pennypiles($n) {
  return partitions($n);
}
