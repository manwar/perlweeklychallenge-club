#!/bin/perl

=pod

The Weekly Challenge - 242
- https://theweeklychallenge.org/blog/perl-weekly-challenge-242

Author: Niels 'PerlBoy' van Dijke

Task 1: Missing Members
Submitted by: Mohammad S Anwar

You are given two arrays of integers.

Write a script to find out the missing members in each other arrays.

=cut

use v5.32;
use common::sense;

use Test2::V0;

use List::MoreUtils qw(uniq);

sub missingMembers {
  my ($n,%n,$r) = ($#_ + 1);

  # Collect all numbers across input
  # and store against their input index
  for my $i (0 .. $n - 1) {
    $r->[$i] = [];
    for (uniq($_[$i]->@*)) {
      push(@{$n{$_}},$i);
    }
  }

  # Find uniq numbers across input 
  # and create output
  for my $i (sort { $a <=> $b } keys %n) {
    if ($n{$i}->@* < $n) {
      map { push($r->[$_]->@*,$i) } $n{$i}->@*;
    }
  }
  return $r;
}

is(missingMembers([1,2,3],[2,4,6]),
                  [[1,3],[4,6]]);
is(missingMembers([0,1,2,3],[1,2,3,4],[2,3,4,5]),
                  [[0,1],[1,4],[4,5]]);
is(missingMembers([1],[1]),[[],[]]);

done_testing;
