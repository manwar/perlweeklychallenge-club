#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
use feature 'state';
use bigint;
use Math::Prime::Util 'is_prime';

no warnings qw(experimental::signatures);

my $count = $ARGV[0] || 13;

sub next_perrin
{
  state @perrin;

  if (! @perrin)
  {
    @perrin = (3,0,2);
  }
  else
  {
    push(@perrin, $perrin[-2] + $perrin[-3]);
  }

  shift @perrin if @perrin == 4;

  return $perrin[-1];
}

my @pp;

while (@pp < $count)
{
  my $next = next_perrin;
  next if @pp && $next <= $pp[-1];
  next unless is_prime($next);
  push(@pp, $next);
}

say join(", ", @pp);
