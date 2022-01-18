#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(eban(100),[2, 4, 6, 30, 32, 34, 36, 40, 42, 44, 46, 50, 52, 54, 56, 60, 62, 64, 66],
          'example 1');

sub eban {
  my $mx=shift;
  my @units=(1,0,1,0,1,0,1,0,0,0);
  my @tens=(1,0,0,1,1,1,1,0,0,0,0);
  my @out;
  foreach my $i (0..$mx) {
    if ($tens[int($i/10)] && $units[$i%10] && $i != 0) {
      push @out,$i;
    }
  }
  return \@out;
}
