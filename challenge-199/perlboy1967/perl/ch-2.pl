#!/bin/perl

=pod

The Weekly Challenge - 199
- https://theweeklychallenge.org/blog/perl-weekly-challenge-199/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Good Triplets
Submitted by: Mohammad S Anwar

You are given an array of integers, @array and three integers $x,$y,$z.

Write a script to find out total Good Triplets in the given array.

A triplet array[i], array[j], array[k] is good if it satisfies the following conditions:

a) 0 <= i < j < k <= n (size of given array)
b) abs(array[i] - array[j]) <= x
c) abs(array[j] - array[k]) <= y
d) abs(array[i] - array[k]) <= z

=cut

use v5.16;
use common::sense;


use Test::More;
use Test::Deep qw(cmp_deeply);


sub goodTriplets ($$$\@) {
  my ($x,$y,$z,$arIn) = @_;

  my $arOut = [];

  for my $i (0 .. scalar(@$arIn) - 3) {
    for my $j ($i + 1 .. scalar(@$arIn) - 2) {
      for my $k ($j + 1 .. scalar(@$arIn) - 1) {
        push(@$arOut,[$$arIn[$i],$$arIn[$j],$$arIn[$k]]) 
          if (abs($$arIn[$i] - $$arIn[$j]) <= $x and
              abs($$arIn[$j] - $$arIn[$k]) <= $y and
              abs($$arIn[$i] - $$arIn[$k]) <= $z);
      }
    }
  }

  return $arOut;
}


cmp_deeply(goodTriplets(7,2,3,@{[3,0,1,1,9,7]}),
           [[3,0,1],[3,0,1],[3,1,1],[0,1,1]]);
cmp_deeply(goodTriplets(0,0,1,@{[1,1,2,2,3]}),
           []);
cmp_deeply(goodTriplets(3,2,1,@{[1,4,2,0,3]}),
           [[1,4,2],[1,2,0],[4,2,3]]);

done_testing;
