#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
use feature 'state';
use bigint;
use Math::Prime::Util 'is_prime';

no warnings qw(experimental::signatures);

my $count = $ARGV[0] || 10;

sub next_padovan
{
  state @padovan = ();

  if (@padovan < 2)
  {
    push(@padovan, 1);
  }
  else
  {
    push(@padovan, $padovan[-2] + $padovan[-3]);
  }

  shift @padovan if @padovan == 4;

  return $padovan[-1];
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
