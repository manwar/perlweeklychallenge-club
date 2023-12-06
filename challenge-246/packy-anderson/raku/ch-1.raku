#!/usr/bin/env raku
use v6;

sub sixOutOfFourtyNine {
  return (1 .. 49).pick(6).sort;
}

sub solution {
  my @arr = sixOutOfFourtyNine();
  say @arr.join("\n");
}

say "Output:";
solution();