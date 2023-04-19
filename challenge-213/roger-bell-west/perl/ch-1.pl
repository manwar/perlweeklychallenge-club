#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(funsort([1, 2, 3, 4, 5, 6]), [2, 4, 6, 1, 3, 5], 'example 1');
is_deeply(funsort([1, 2]), [2, 1], 'example 2');
is_deeply(funsort([1]), [1], 'example 3');

sub funsort($l0) {
  my @l = sort @{$l0};
  my (@a, @b);
  foreach my $k (@l) {
    if ($k % 2 == 0) {
      push @a, $k;
    } else {
      push @b, $k;
    }
  }
  push @a, @b;
  return \@a;
}
