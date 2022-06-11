#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
use feature 'state';
use Math::Prime::Util 'is_prime';

no warnings qw(experimental::signatures);

my $count = $ARGV[0] || 10;

sub next_padovan
{
  state @padovan = (1, 1, 1);
  state $index   = 0;
  
  while (@padovan <= $index)
  {
    push(@padovan, $padovan[-2] + $padovan[-3]);
  }

  return $padovan[$index++];
}

my @pp;

while (@pp < $count)
{
  my $next = next_padovan;
  next if @pp && $next eq $pp[-1];
  next unless is_prime($next);
  push(@pp, $next);
}

say join(", ", @pp);
