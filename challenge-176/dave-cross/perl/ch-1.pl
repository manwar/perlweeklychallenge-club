#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my $i = 1;

while (1) {
  my %perms;
  for (1 .. 6) {
    my $product = $_ * $i;
    # split and sort the digits in the product
    my $sorted_product = join '', sort split //, $product;
    $perms{$sorted_product} = 1;
  }

  # If the products were all permutations of each other
  # then the hash will only have a single key
  last if keys %perms == 1;

  ++$i;
}

say $i;
