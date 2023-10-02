#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(uniquesum([2, 1, 3, 2]), 4, 'example 1');
is(uniquesum([1, 1, 1, 1]), 0, 'example 2');
is(uniquesum([2, 1, 3, 4]), 10, 'example 3');

use List::Util qw(sum0);

sub uniquesum($a) {
  my %c;
  map {$c{$_}++} @{$a};
  return sum0(grep {$c{$_} == 1} keys %c);
}
