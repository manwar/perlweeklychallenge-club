#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(relativesort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6]), [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9], 'example 1');
is_deeply(relativesort([3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2]), [1, 3, 3, 3, 2, 2, 4, 4, 6], 'example 2');
is_deeply(relativesort([3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2]), [1, 1, 1, 0, 0, 3, 2, 4, 5], 'example 3');

sub relativesort($list1, $list2) {
  my %c;
  map {$c{$_}++} @{$list1};
  my @out;
  foreach my $i (@{$list2}) {
    push @out, ($i) x ($c{$i} || 0);
    delete $c{$i};
  }
  foreach my $i (sort keys %c) {
    push @out, ($i) x ($c{$i} || 0);
  }
  return \@out;
}
