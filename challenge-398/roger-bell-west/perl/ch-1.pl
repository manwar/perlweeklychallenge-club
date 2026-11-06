#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(divisibleaverage([18, 5, 7, 11]), 18, 'example 1');
is(divisibleaverage([6, 12, 18, 24, 30, 40]), 18, 'example 2');
is(divisibleaverage([3, 9, 15, 21, 27]), 0, 'example 3');
is(divisibleaverage([6, 12, 14, 20]), 9, 'example 4');
is(divisibleaverage([6, 6, 6, 12, 12]), 8, 'example 5');

use List::Util qw(sum);

sub divisibleaverage($a) {
  my @b = grep { $_ % 6 == 0 } @{$a};
  if (scalar @b == 0) {
    return 0;
  }
  int(sum(@b) / (scalar @b) + 0.5);
}
