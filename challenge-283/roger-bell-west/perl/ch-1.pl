#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(uniquenumber([3, 3, 1]), 1, 'example 1');
is(uniquenumber([3, 2, 4, 2, 4]), 3, 'example 2');
is(uniquenumber([1]), 1, 'example 3');
is(uniquenumber([4, 3, 1, 1, 1, 4]), 3, 'example 4');

sub uniquenumber($a) {
  my %c;
  map {$c{$_}++} @{$a};
  while (my ($k, $v) = each %c) {
    if ($v == 1) {
      return $k;
    }
  }
  return -1;
}
