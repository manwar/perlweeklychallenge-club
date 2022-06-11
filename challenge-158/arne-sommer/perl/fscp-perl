#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'state';
use Math::Prime::Util 'is_prime';
use List::Util 'sum';

my $limit = $ARGV[0] || 1000;

my @fscp;

while (1)
{
  state $current = 0;

  my $mapped = 3 * $current ** 2 + 3 * $current++ + 1;

  last if $mapped >= $limit;

  push(@fscp, $mapped) if is_prime($mapped);
}

say join(", ", @fscp);
