#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 1;

is_deeply(fivenumber((0.0, 0.0, 1.0, 2.0, 63.0, 61.0, 27.0, 13.0)),
          [0.0, 0.5, 7.5, 44.0, 63.0],
          'example 1');

sub fivenumber(@n0) {
  my @n = sort(@n0);
  my $nl = scalar @n - 1;
  my @o = ($n[0]);
  foreach my $quartile (1..3) {
    my $bx = $quartile * $nl;
    my $base = int($bx / 4);
    my $v = $n[$base];
    if ($bx % 4 != 0) {
      $v = ($n[$base] + $n[$base+1]) / 2
    }
    push @o,$v;
  }
  push @o,$n[-1];
  return \@o;
}
