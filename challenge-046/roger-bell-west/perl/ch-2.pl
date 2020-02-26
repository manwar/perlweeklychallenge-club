#! /usr/bin/perl

use strict;
use warnings;

my @rooms=(1) x 500;

foreach my $n (2..500) {
  for (my $k=$n-1;$k<500;$k+=$n) {
    $rooms[$k]=1-$rooms[$k];
  }
}

print map {$_+1,"\n"} grep {$rooms[$_]==1} (0..$#rooms);
