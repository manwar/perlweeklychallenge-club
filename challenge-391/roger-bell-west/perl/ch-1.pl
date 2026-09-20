#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(arraymedian([2], [4]), 3, 'example 1');
is(arraymedian([1, 2, 3], [7, 8, 9, 10]), 7, 'example 2');
is(arraymedian([], [10, 20, 30, 40]), 25, 'example 3');
is(arraymedian([100], [1, 2, 3, 4, 5, 6, 7]), 4.5, 'example 4');
is(arraymedian([1, 2, 2], [2, 2, 3]), 2, 'example 5');

sub arraymedian($a, $b) {
  my @nn = sort {$::a <=> $::b} (@{$a}, @{$b});
  my $i = int(scalar @nn / 2);
  if (scalar @nn % 2 == 0) {
    return ($nn[$i - 1] + $nn[$i]) / 2;
  } else {
    return $nn[$i];
  }
}
