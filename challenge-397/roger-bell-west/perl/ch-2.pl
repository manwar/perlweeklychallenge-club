#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(binaryreflection([3, 6, 12]), [3, 6, 12], 'example 1');
is_deeply(binaryreflection([1, 2, 4, 8]), [1, 2, 4, 8], 'example 2');
is_deeply(binaryreflection([7, 8, 9, 10]), [8, 10, 7, 9], 'example 3');
is_deeply(binaryreflection([5, 9, 15, 17]), [5, 9, 15, 17], 'example 4');
is_deeply(binaryreflection([11, 13, 14, 19]), [14, 13, 11, 19], 'example 5');

sub reflect($a) {
  my @p;
  my $am = $a;
  while (1) {
    push @p, $am % 2;
    $am >>= 1;
    if ($am == 0) {
      last;
    }
  }
  my $ar = 0;
  my $s = scalar @p;
  foreach my $n (@p) {
    $s -= 1;
    $ar += $n << $s;
  }
  $ar;
}

sub binaryreflection($ax) {
  my @k = map {reflect($_)} @{$ax};
  my @i = sort {
    $k[$::a] <=> $k[$::b]
      ||
    $ax->[$::a] <=> $ax->[$::b]
  } (0 .. $#{$ax});
  [map {$ax->[$_]} @i];
}
