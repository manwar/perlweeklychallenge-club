#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

use Math::Prime::Util qw/is_prime/;

no warnings qw(experimental::signatures);

my $n = $ARGV[0] // 10;

die "Please specify a positive integer" unless $n =~ /^[1-9]\d*$/;

my @smith_seq;

my $candidate = 3;

while (1)
{
  $candidate++;
    
  last if @smith_seq == $n;
  next if is_prime($candidate);
  
  my @digits = split(//, $candidate);
  my $left = 0;
  map { $left += $_ } @digits;

  my $right = 0;
  my @prime_factors = factors($candidate);
  
  for my $prime (@prime_factors)
  {
    my @digits = split(//, $prime);
    map { $right += $_ } @digits;
  }
  
  push(@smith_seq, $candidate) if $left == $right;
}

say join(", ", @smith_seq);

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
