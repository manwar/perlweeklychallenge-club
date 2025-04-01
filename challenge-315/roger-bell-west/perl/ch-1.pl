#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(findwords(['the', 'weekly', 'challenge'], 'e'), [0, 1, 2], 'example 1');
is_deeply(findwords(['perl', 'raku', 'python'], 'p'), [0, 2], 'example 2');
is_deeply(findwords(['abc', 'def', 'bbb', 'bcd'], 'b'), [0, 2, 3], 'example 3');

sub findwords($a, $b) {
  my @out;
  while (my ($i, $x) = each @{$a}) {
    if (index($x, $b) > -1) {
      push @out, $i;
    }
  }
  \@out;
}
