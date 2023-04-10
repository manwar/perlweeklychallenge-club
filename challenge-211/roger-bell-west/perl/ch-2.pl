#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(splitsameaverage([1, 2, 3, 4, 5, 6, 7, 8]), 1, 'example 1');
is(splitsameaverage([1, 3]), 0, 'example 2');
is(splitsameaverage([1, 2, 3]), 1, 'example 3');

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);

sub splitsameaverage($a) {
  my $ss = sum(@{$a});
  my $ml = scalar @{$a};
  my $mx = int($ml / 2);
  my $ssa = 0;
  foreach my $n (1 .. $mx) {
    my $ic = combinations($a, $n);
    while (my $c = $ic->next) {
      my $ca = sum(@{$c});
      if ($ca / $n == ($ss - $ca) / ($ml - $n)) {
        $ssa = 1;
        last;
      }
    }
    if ($ssa) {
      last;
    }
  }
  return $ssa;
}
