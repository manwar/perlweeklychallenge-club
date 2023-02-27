#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(thirdhighest([5, 3, 4]), 3, 'example 1');
is(thirdhighest([5, 6]), 6, 'example 2');
is(thirdhighest([5, 4, 4, 3]), 3, 'example 3');

sub thirdhighest($l) {
  my @v = reverse sort keys %{{map {$_ => 1} @{$l}}};
  if (scalar @v == 0) {
    return 0;
  } elsif (scalar @v <= 2) {
    return $v[0];
  } else {
    return $v[2];
  }
}
