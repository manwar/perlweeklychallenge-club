#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(leftrightsumdiff([10, 4, 8, 3]), [15, 1, 11, 22], 'example 1');
is_deeply(leftrightsumdiff([1]), [0], 'example 2');
is_deeply(leftrightsumdiff([1, 2, 3, 4, 5]), [14, 11, 6, 1, 10], 'example 3');

sub leftrightsumdiff($a) {
  my $al = $#{$a};
  my @left = (0);
  my @right = (0);
  foreach my $i (0 .. $al - 1) {
    push @left, $left[$i] + $a->[$i];
    push @right, $right[$i] + $a->[$al - $i];
  }
  @right = reverse @right;
  my @out;
  foreach my $i (0 .. $al) {
    push @out, abs($left[$i] - $right[$i]);
  }
  return \@out;
}
