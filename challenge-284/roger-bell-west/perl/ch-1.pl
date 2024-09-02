#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(luckyinteger([2, 2, 3, 4]), 2, 'example 1');
is(luckyinteger([1, 2, 2, 3, 3, 3]), 3, 'example 2');
is(luckyinteger([1, 1, 1, 3]), -1, 'example 3');

sub luckyinteger($a) {
  my %c;
  map {$c{$_}++} @{$a};
  my @c1 = reverse sort values %c;
  my @c2 = reverse sort keys %c;
  foreach my $v1 (@c1) {
    foreach my $v2 (@c2) {
      if ($c{$v2} == $v1 && $v1 == $v2) {
        return $v2;
      }
    }
  }
  return -1;
}
