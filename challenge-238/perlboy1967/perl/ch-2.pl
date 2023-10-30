#!/bin/perl

=pod

The Weekly Challenge - 238
- https://theweeklychallenge.org/blog/perl-weekly-challenge-238

Author: Niels 'PerlBoy' van Dijke

Task 2: Persistence Sort
Submitted by: Mohammad S Anwar

You are given an array of positive integers.

Write a script to sort the given array in increasing order with respect
to the count of steps required to obtain a single-digit number by multiplying
its digits recursively for each array element. If any two numbers have the
same count of steps, then print the smaller number first.

=cut

use v5.32;
use common::sense;
use feature 'signatures';

use Test::More;
use Test::Deep qw(cmp_deeply);

use List::MoreUtils qw(slide);
use Memoize;

memoize 'cnt_steps';

sub cnt_steps($i) {
  my $n = 0;

  while (1) {
    my @d = split(//,$i);
    last if (@d == 1);
    $i = slide { $a * $b } @d;
    $n++;
  } 

  return $n;
}

sub persistenceSort (@numbers) {
  sort { cnt_steps($a) <=> cnt_steps($b) || $a <=> $b} @numbers;
}

cmp_deeply([persistenceSort(15,99,1,34)],[1,15,34,99]);
cmp_deeply([persistenceSort(50,25,33,22)],[22,33,50,25]);

done_testing;
