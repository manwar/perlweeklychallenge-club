#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use Math::Prime::Util 'is_prime';

my $number = int($ARGV[0] || 10001);

my $count     = 0;
my $candidate = 0;

while (++$candidate)
{
  next unless is_prime($candidate);
  $count++;

  last if $count == $number;
}

say $candidate;
