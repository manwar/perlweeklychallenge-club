#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(countequaldivisible([3, 1, 2, 2, 2, 1, 3], 2), 4, 'example 1');
is(countequaldivisible([1, 2, 3], 1), 0, 'example 2');

use Algorithm::Combinatorics qw(combinations);

sub countequaldivisible($a, $k) {
  my $s = 0;
  foreach my $c (combinations([0 .. $#{$a}], 2)) {
    if ($a->[$c->[0]] == $a->[$c->[1]] && $c->[0] * $c->[1] % $k == 0) {
      $s++;
    }
  }
  return $s;
}
