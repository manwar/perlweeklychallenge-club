#!/bin/perl

=pod

The Weekly Challenge - 264
- https://theweeklychallenge.org/blog/perl-weekly-challenge-264

Author: Niels 'PerlBoy' van Dijke

Task 2: Target Array
Submitted by: Mohammad Sajid Anwar

You are given two arrays of integers, @source and @indices. The @indices can
only contains integers 0 <= i < size of @source.

Write a script to create target array by insert at index $indices[i] the
value $source[i].

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(pairwise);

sub targetArray($arSrc,$arIdx) {
  my @l;
  pairwise {
    splice(@l,$b,1,grep { defined } $a,$l[$b]);
  } @$arSrc,@$arIdx;
  @l;
}

is([targetArray([0,1,2,3,4],[0,1,2,2,1])],
   [0,4,1,3,2],'Example 1');
is([targetArray([1,2,3,4,0],[0,1,2,3,0])],
   [0,1,2,3,4],'Example 2');
is([targetArray([1],[0])],
   [1],'Example 3');

done_testing;
