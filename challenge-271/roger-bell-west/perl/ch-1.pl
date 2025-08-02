#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(maximumones([[0, 1], [1, 0]]), 1, 'example 1');
is(maximumones([[0, 0, 0], [1, 0, 1]]), 2, 'example 2');
is(maximumones([[0, 0], [1, 1], [0, 0]]), 2, 'example 3');

use List::Util qw(sum max);

sub maximumones($a) {
  my @ax = map {sum(@{$_})} @{$a};
  my $am = max(@ax);
  while (my ($i, $n) = each @ax) {
    if ($n == $am) {
      return $i + 1;
    }
  }
  return 0;
}
