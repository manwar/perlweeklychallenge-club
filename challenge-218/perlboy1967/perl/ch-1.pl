#!/bin/perl

=pod

The Weekly Challenge - 217
- https://theweeklychallenge.org/blog/perl-weekly-challenge-217

Author: Niels 'PerlBoy' van Dijke

Task 1: Maximum Product
Submitted by: Mohammad S Anwar

You are given a list of 3 or more integers.

Write a script to find the 3 integers whose product is the maximum and return it.

=cut

use v5.16;

use common::sense;

use List::Util qw(product);

use Test::More;

sub maxProduct (@) {
  my (@n,@p);

  # Find negative and positive factors
  for (@_) {
    $_ < 0 ? push(@n,$_) : 
    $_ > 0 ? push(@p,$_) :
    0;
  }

  # If we have an odd number of negative factors, 
  # ditch the one closest to zero
  @n = sort {$a <=> $b} @n;
  pop @n if (@n % 2);

  product(@p,@n);
}

is(maxProduct(3,2,1),6);
is(maxProduct(4,1,3,2),24);
is(maxProduct(-1,0,1,3,1),3);
is(maxProduct(-8,2,-9,0,-4,3),432);
is(maxProduct(-3,-2,-1,0,1,2,3),36);

done_testing;
