#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
use List::Util qw[min];

# Input
my @matrix = (
  [1, 1, 0, 1],
  [1, 1, 0, 0],
  [0, 1, 1, 1],
  [1, 0, 1, 1]
);

# Find square
my $M = scalar @matrix;
my $N = scalar @{$matrix[0]};
my $count = 0;

for(my $i = 0; $i < $M - 1; $i++){
  for(my $j = 0; $j < $N - 1; $j++){
    my $min = min($M - $i, $N - $j);

    for (1..$min-1) {
      $count++ if ($matrix[$i][$j] == 1 && $matrix[$i + $_][$j] == 1 &&
        $matrix[$i][$j + $_] == 1 && $matrix[$i + $_][$j + $_] == 1);
    }
  }
}

# Output
say $count;