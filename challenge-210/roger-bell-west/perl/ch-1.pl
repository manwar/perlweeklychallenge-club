#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(killandwin([2, 3, 1]), 6, 'example 1');
is(killandwin([1, 1, 2, 2, 2, 3]), 11, 'example 2');

use List::Util qw(sum);

sub killandwin($a) {
  return sum(@{$a});
}
