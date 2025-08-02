#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(sortletters(['R', 'E', 'P', 'L'], [3, 2, 1, 4]), 'PERL', 'example 1');
is(sortletters(['A', 'U', 'R', 'K'], [2, 4, 1, 3]), 'RAKU', 'example 2');
is(sortletters(['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3]), 'PYTHON', 'example 3');

sub sortletters($a, $n) {
  my @out = ("") x scalar @{$a};
  while (my ($i, $l) = each @{$a}) {
    $out[$n->[$i] - 1] = $l;
  }
  return join('', @out);
}
