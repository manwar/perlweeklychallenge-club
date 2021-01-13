#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Input
my @R = (0.5, 1.1, 0.3, 0.7);

# Triplet Sum
my $res = 0;
my $len = scalar @R;

for(my $i = 0; $i < $len - 2; $i++) {
  my $sum = $R[$i] + $R[$i + 1] + $R[$i + 2];

  if($sum > 1 && $sum < 2) {
    $res = 1;
    last;
  }
}

# Output
say $res;