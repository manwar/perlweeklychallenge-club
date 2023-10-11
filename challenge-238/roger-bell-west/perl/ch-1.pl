#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(runningsum([1, 2, 3, 4, 5]), [1, 3, 6, 10, 15], 'example 1');
is_deeply(runningsum([1, 1, 1, 1, 1]), [1, 2, 3, 4, 5], 'example 2');
is_deeply(runningsum([0, -1, 1, 2]), [0, -1, 0, 2], 'example 3');

sub runningsum($a) {
  my @b = @{$a};
  foreach my $i (1..$#{$a}) {
    $b[$i] += $b[$i-1];
  }
  return \@b;
}
