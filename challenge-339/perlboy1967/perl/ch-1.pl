#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-339#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Max Diff
Submitted by: Mohammad Sajid Anwar

You are given an array of integers having four or more elements.

Write a script to find two pairs of numbers from this list (four numbers total)
so that the difference between their products is as large as possible.

In the end return the max difference.

|| With Two pairs (a, b) and (c, d), the product difference is (a * b) - (c * d).


=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use List::Util qw(min);

sub maxDiff (@ints) {
  my @i = sort { $a <=> $b } @ints;
  my (@n,@p,$max);

  # Collect positive and not-positive numbers
  for (@i) {
    push(@n,$_) if $_ <= 0;
    unshift(@p,$_) if $_ > 0;
  }

  # First find our max and reduce its source list
  if (@p > 1 and @n > 1) {
    if ($p[0]*$p[1] >= $n[0]*$n[1]) {
      $max = (shift @p) * (shift @p);
    } else {
      $max = (shift @n) * (shift @n);
    }
  } elsif (@p > 1) {
    $max = (shift @p) * (shift @p);
  } elsif (@n > 1) {
    $max = (shift @n) * (shift @n);
  } else {
    $max = (shift @n) * pop(@p);
  }

  # Find the minimum with left over data
  my @min;
  push(@min,$n[-1]*$p[-1]) if (@n and @p);
  push(@min,$p[-1]*$p[-2]) if @p >= 2;
  push(@min,$n[-1]*$n[-2]) if @n >= 2;

  return $max - min(@min)
}

is(maxDiff(5,9,3,4,6),42,'Example 1');
is(maxDiff(1,-2,3,-4),5,'Example 2');
is(maxDiff(-3,-1,-2,-4),10,'Example 3');
is(maxDiff(10,2,0,5,1),50,'Example 4');
is(maxDiff(7,8,9,10,10),44,'Example 5');
is(maxDiff(0,1,2,3),6,'Own example 1');
is(maxDiff(-2,-1,0,1,2),2,'Own example 2');

done_testing;
