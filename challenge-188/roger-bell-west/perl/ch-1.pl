#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

use Algorithm::Combinatorics qw(combinations);

is(divisiblepairs([4, 5, 1, 6], 2), 2, 'example 1');
is(divisiblepairs([1, 2, 3, 4], 2), 2, 'example 2');
is(divisiblepairs([1, 3, 4, 5], 3), 2, 'example 3');
is(divisiblepairs([5, 1, 2, 3], 4), 2, 'example 4');
is(divisiblepairs([7, 2, 4, 5], 4), 1, 'example 5');

sub divisiblepairs($a, $k) {
  my $ct = 0;
  my $iter = combinations($a, 2);
  while (my $b = $iter->next) {
    if (($b->[0] + $b->[1]) % $k == 0) {
      $ct++;
    }
  }
  return $ct;
}
