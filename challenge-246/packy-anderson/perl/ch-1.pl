#!/usr/bin/env perl
use v5.38;

use List::Util qw( shuffle );

sub sixOutOfFourtyNine {
  return sort { $a <=> $b } ( shuffle(1 .. 49) )[0 .. 5];
}

sub solution {
  my @arr = sixOutOfFourtyNine();
  say join("\n", @arr);
}

say "Output:";
solution();