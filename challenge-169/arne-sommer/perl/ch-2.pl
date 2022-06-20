#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
no warnings 'experimental::signatures';

use Math::Prime::Util 'is_prime';

my $count = shift(@ARGV) || 20;

die "Please specify a positive integer" unless $count =~ /^[1-9]\d*$/;

my @achilles = ();

my $candidate = 0;

while (@achilles != $count)
{
  $candidate++;

  push(@achilles, $candidate) if is_achilles($candidate);
}

say join(", ", @achilles);

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

sub divisors ($number)
{
  my @divisors;
  
  for my $candidate (2 .. $number/2)
  {
    push(@divisors, $candidate) if $number % $candidate == 0;
  }
  
  return @divisors;
}

sub is_powerful ($number)
{
  return 1 if $number == 1;

  my @factors = factors($number);

  my %values;

  for my $val (@factors)
  {
    $values{$val}++;
  }
  
  for my $count (values %values)
  {
    return 0 if $count == 1;
  }

  return 1;
}

sub is_perfect ($number)
{
  return 1 if $number <= 1;

  my @divisors = divisors($number);

  return 0 unless @divisors;

  for my $divisor (@divisors)
  {
    my $current = $divisor;

    $current *= $divisor while $current < $number;

    return 1 if $current == $number;
  }

  return 0;
}

sub is_achilles ($number)
{
  return 0 unless is_powerful($number);
  return 0 if     is_perfect($number);
  return 1;
}
