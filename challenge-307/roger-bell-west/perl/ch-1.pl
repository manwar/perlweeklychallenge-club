#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(checkorder([5, 2, 4, 3, 1]), [0, 2, 3, 4], 'example 1');
is_deeply(checkorder([1, 2, 1, 1, 3]), [1, 3], 'example 2');
is_deeply(checkorder([3, 1, 3, 2, 3]), [0, 1, 3], 'example 3');

sub checkorder($a) {
  my @b = sort {$::a <=> $::b} @{$a};
  my @out;
  foreach my $i (0 .. $#b) {
    if ($a->[$i] != $b[$i]) {
      push @out, $i;
    }
  }
  \@out;
}
