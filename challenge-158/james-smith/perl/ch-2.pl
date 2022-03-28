#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Math::Prime::Util qw(is_prime);

my $N = shift || 1000;

for(
  my $x = 1;
  ( my $y = 3 * $x * ($x+1) + 1 ) <= $N;
  $x++
) {
  say $y if is_prime $y;
}
