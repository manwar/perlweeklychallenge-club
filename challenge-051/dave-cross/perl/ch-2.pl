#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

NUMBER:
for my $n (100 ... 999) {
  my %product;

  my ($x, $y, $z) = split //, $n;

  $product{$_}++ for ($x, $y, $z, $x * $y, $y * $z, $x * $y * $z);

  # If all of those products are different, then the hash
  # will have exactly six keys
  say "$n is colourful" if keys %product == 6;
}
