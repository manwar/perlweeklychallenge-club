#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Math::Prime::Util 'is_prime';

my $limit = int(shift(@ARGV) || 0) || 1000;

say $limit;

my @result;

for my $current (1 .. $limit -1)
{
  next unless is_prime($current);
  next unless $current eq reverse($current);

  push(@result, $current);
}

say join(", ", @result);
