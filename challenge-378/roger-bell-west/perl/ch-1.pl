#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(secondlargestdigit('aaaaa77777'), -1, 'example 1');
is(secondlargestdigit('abcde'), -1, 'example 2');
is(secondlargestdigit('9zero8eight7seven9'), 8, 'example 3');
is(secondlargestdigit('xyz9876543210'), 8, 'example 4');
is(secondlargestdigit('4abc4def2ghi8jkl2'), 4, 'example 5');

sub secondlargestdigit($a) {
  my %p = map {$_ => 1} grep /[0-9]/, split '', $a;
  my @k = reverse sort keys %p;
  if (scalar @k > 1) {
    $k[1];
  } else {
    -1;
  }
}
