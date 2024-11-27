#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(twicelargest([2, 4, 1, 0]), 1, 'example 1');
is(twicelargest([1, 2, 3, 4]), -1, 'example 2');

sub twicelargest($a) {
  my @p = sort {$::b <=> $::a} @{$a};
  if ($p[0] >= 2 * $p[1]) {
    while (my ($i, $c) = each @{$a}) {
      if ($c == $p[0]) {
        return $i;
      }
    }
  }
  -1;
}
