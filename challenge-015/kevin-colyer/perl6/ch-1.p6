#!/usr/bin/perl6
use v6;

use Test;

# 15.1 Write a script to generate first 10 strong and weak prime numbers.
#
#   For example, the nth prime number is represented by p(n).
#
#   p(1) = 1
#   p(2) = 3
#   p(3) = 5
#
#   Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
#   Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2

my @p =   (2,3,*+2 ... ∞).grep: *.is-prime;

my @weak   = (1 .. ∞).map: { @p[$_]  if @p[$_]  <  ( @p[$_-1] + @p[$_+1] ) /2  };
my @strong = (1 .. ∞).map: { @p[$_]  if @p[$_]  >  ( @p[$_-1] + @p[$_+1] ) /2  };


sub MAIN($num where *>1)
{
    say "$num weak primes";
    say @weak[^$num];

    say "$num strong primes";
    say @strong[^$num];
}
