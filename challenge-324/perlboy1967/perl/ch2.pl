#!/bin/perl

=pod

The Weekly Challenge - 324
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-324#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Total XOR
Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the sum of total XOR for every subset of given array.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

use Algorithm::Combinatorics qw(combinations);
use List::AllUtils qw(sum);

sub totalXor (@ints) {
  my $sum = sum(@ints);
  for my $dim (2 .. scalar(@ints)) {
    for my $a (combinations(\@ints,$dim)) {
      my $xor = shift (@$a);
      $xor ^= $_ for (@$a);
      $sum += $xor;
    } 
  }
  return $sum;
}

is(totalXor(1,3),6,'Example 1');
is(totalXor(5,1,6),28,'Example 2');
is(totalXor(3,4,5,6,7,8),480,'Example 3');

done_testing;
