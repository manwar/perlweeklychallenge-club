#! /usr/bin/perl

use strict;
use warnings;

my @N = (2, 7, 9);
my $k = 2;

my @out;
foreach my $j (0..$#N-1) {
  foreach my $i ($j+1..$#N) {
    if ($N[$i]-$N[$j] == $k) {
      push @out,[$i,$j];
    }
  }
}

foreach (@out) {
  print "$_->[0], $_->[1]\n";
}
