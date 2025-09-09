#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(maxdistance([4, 5, 7], [9, 1, 3, 4]), 6, 'example 1');
is(maxdistance([2, 3, 5, 4], [3, 2, 5, 5, 8, 7]), 6, 'example 2');
is(maxdistance([2, 1, 11, 3], [2, 5, 10, 2]), 9, 'example 3');
is(maxdistance([1, 2, 3], [3, 2, 1]), 2, 'example 4');
is(maxdistance([1, 0, 2, 3], [5, 0]), 5, 'example 5');

use List::Util qw(max);
use List::MoreUtils qw(minmax);

sub maxdistance($a, $b) {
  my ($l1, $h1) = minmax(@{$a});
  my ($l2, $h2) = minmax(@{$b});
  return max($h1 - $l2, $h2 - $l1);
}
