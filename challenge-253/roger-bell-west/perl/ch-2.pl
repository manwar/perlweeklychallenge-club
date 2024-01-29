#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(weakestrows([[1, 1, 0, 0, 0], [1, 1, 1, 1, 0], [1, 0, 0, 0, 0], [1, 1, 0, 0, 0], [1, 1, 1, 1, 1]]), [2, 0, 3, 1, 4], 'example 1');
is_deeply(weakestrows([[1, 0, 0, 0], [1, 1, 1, 1], [1, 0, 0, 0], [1, 0, 0, 0]]), [0, 2, 3, 1], 'example 2');

use List::Util qw(sum);

sub weakestrows($aa) {
  my @p = (0 .. $#{$aa});
  my @bb = map {sum(@{$_})} @{$aa};
  @p = sort {$bb[$a] <=> $bb[$b]} @p;
  return \@p;
}
