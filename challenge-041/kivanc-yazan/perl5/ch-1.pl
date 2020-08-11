#!/usr/bin/env perl
use warnings;
use strict;
use Math::Prime::Util qw/is_prime factor/;

# Problem: Write a script to display attractive number between 1 and 50.

for my $i (1..50){
  my @factors = factor($i);
  my $factor_count = scalar(@factors);
  if (is_prime($factor_count)){
    print "$i (@factors)\n";
  }
}
