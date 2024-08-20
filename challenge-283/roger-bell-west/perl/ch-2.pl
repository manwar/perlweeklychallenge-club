#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(digitcountvalue([1, 2, 1, 0]), 1, 'example 1');
is(digitcountvalue([0, 3, 0]), 0, 'example 2');

sub digitcountvalue($a) {
  my %c;
  map {$c{$_}++} @{$a};
  foreach my $ix (0 .. $#{$a}) {
    if ($a->[$ix] != ($c{$ix} || 0)) {
      return 0;
    }
  }
  return 1;
}
