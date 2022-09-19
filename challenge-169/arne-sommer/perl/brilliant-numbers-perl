#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
no warnings 'experimental::signatures';

use Math::Prime::Util 'is_prime';

my $count = shift(@ARGV) || 20;

die "Please specify a positive integer" unless $count =~ /^[1-9]\d*$/;

my @bn = ();

my $candidate = 0;

while (@bn != $count)
{
  $candidate++;

  push(@bn, $candidate) if is_brilliant($candidate);
}

say join(", ", @bn);

sub factors ($number)
{
  return (1)       if $number == 1;
  return ($number) if is_prime($number);

  my @factors;

  for my $candidate (grep { is_prime($_) } 2 .. $number / 2)
  {
    while ($number % $candidate == 0)
    {
      push(@factors, $candidate);
      $number /= $candidate;
    }
  }
    
  return @factors;
}

sub is_brilliant ($number)
{
  my @factors = factors($number);
  return 0 unless @factors == 2;
  return 0 unless length($factors[0]) == length($factors[1]);
  return 1;
}
