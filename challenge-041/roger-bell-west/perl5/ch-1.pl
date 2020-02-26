#! /usr/bin/perl

use strict;
use warnings;

use Math::Prime::Util qw(factor is_prime);

foreach my $c (1..50) {
  if (is_prime(scalar factor($c))) {
    print "$c\n";
  }
}

