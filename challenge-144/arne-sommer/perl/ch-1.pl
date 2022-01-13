#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use Math::Prime::Util 'is_prime';
use List::Util 'uniq';
 
my $limit  = 100;
my @primes = grep { is_prime($_) } (1 .. $limit / 2);

my @result;

for my $a (@primes)
{
  for my $b (@primes)
  {
    my $product = $a * $b;
    push(@result, $product) if $product <= $limit;   
  }
}

say join(", ", uniq sort{ $a <=> $b } @result);
