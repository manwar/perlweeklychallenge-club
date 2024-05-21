#!/bin/perl

=pod

The Weekly Challenge - 270
- https://theweeklychallenge.org/blog/perl-weekly-challenge-270

Author: Niels 'PerlBoy' van Dijke

ask 2: Distribute Elements
Submitted by: Mohammad Sajid Anwar

You are give an array of integers, @ints and two integers, $x and $y.

Write a script to execute one of the two options:

Level 1:
Pick an index i of the given array and do $ints[i] += 1

Level 2:
Pick two different indices i,j and do $ints[i] +=1 and $ints[j] += 1.

You are allowed to perform as many levels as you want to make every elements in
the given array equal. There is cost attach for each level, for Level 1, the
cost is $x and $y for Level 2.

In the end return the minimum cost to get the work done.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

# Task 2
use List::AllUtils qw(max);

sub distributeElements ($ar,$c1,$c2) {
  my ($m,$c) = (max(@$ar),0);
  my @i = grep { $_ < $m } @$ar;
  while (@i) { 
    my @n = (0);
    if ($c2 < 2 * $c1 && $#i) {
      $c += $c2; unshift(@n,1);
    } else {
      $c += $c1;
    }
    $i[$_]++ for (@n);
    @i = grep { $_ < $m } @i;
  }
  return $c;
}

is(distributeElements([4,1],3,2),9,'Example 1');
is(distributeElements([2,3,3,3,5],2,1),6,'Example 2');
is(distributeElements([3,3,4,4],1,2),2,'Own test');

done_testing;
