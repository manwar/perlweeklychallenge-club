#!/bin/perl

=pod

The Weekly Challenge - 187
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-187/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Magical Triplets
Submitted by: Mohammad S Anwar

You are given a list of positive numbers, @n, having at least 3 numbers.

Write a script to find the triplets (a, b, c) from the given list that satisfies 
the following rules.

1. a + b > c
2. b + c > a
3. a + c > b
4. a + b + c is maximum.

In case, you end up with more than one triplets having the maximum then pick the 
triplet where a >= b >= c.

=cut

use v5.16;
use warnings;

use List::Util qw(sum max);
use List::MoreUtils qw(firstval);
use Algorithm::Combinatorics qw(combinations);

use Test::More;
use Test::Deep qw(cmp_deeply);use Test::Deep qw(cmp_deeply);

sub magicalTriplets {
  my %sum;
  for (combinations([@_],3)) {
    my ($x,$y,$z) = @$_;
    push(@{$sum{sum @$_}}, [sort {$b <=> $a} @$_])
      if ($x+$y>$z && $y+$z>$x && $x+$z>$y);
  }

  return [] unless keys %sum;

  my $max = max(keys %sum);
  if (scalar @{$sum{$max}} > 1) {
     return firstval { $$_[0]>=$$_[1] && $$_[1]>=$$_[2] } @{$sum{$max}};
  } else {
    return $sum{$max}[0];
  }
}

cmp_deeply(magicalTriplets(1,2,3,2),[3,2,2]);
cmp_deeply(magicalTriplets(1,3,2),[]);
cmp_deeply(magicalTriplets(1,1,2,3),[]);
cmp_deeply(magicalTriplets(2,4,3),[4,3,2]);

done_testing;


