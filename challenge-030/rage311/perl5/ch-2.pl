#!/usr/bin/env perl

use 5.030;
use strict;
use warnings;

my %solutions;

for my $i (1..11) {
  for my $j (1..11) {
    for my $k (1..11) {
      $solutions{join ',', sort $i, $j, $k}++ if
        (!($i % 2) || !($j % 2) || !($k % 2)) && $i + $j + $k == 12;
    }
  }
}

say join "\n", sort keys %solutions;

