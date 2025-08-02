#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(thirdmaximum([5, 6, 4, 1]), 4, 'example 1');
is(thirdmaximum([4, 5]), 5, 'example 2');
is(thirdmaximum([1, 2, 2, 3]), 1, 'example 3');

sub thirdmaximum($a) {
  my @p = sort {$::b <=> $::a} keys %{{map {$_ => 1} @{$a}}};
  if (scalar @p > 2) {
    $p[2];
  } else {
    $p[0];
  }
}
