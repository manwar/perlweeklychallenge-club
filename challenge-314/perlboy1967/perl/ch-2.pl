#!/bin/perl

=pod

The Weekly Challenge - 314
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-314#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Sort Column
Submitted by: Mohammad Sajid Anwar

You are given a list of strings of same length.

Write a script to make each column sorted lexicographically by deleting any non sorted columns.

Return the total columns deleted.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

sub sortColomn (@list) {
  my $n = 0;

  # Expand list to list of list (of characters)
  my @l = map { [split//] } @list;

  for my $i (0 .. length($list[0]) - 1) {
    my @c;
    for my $j (0 .. $#l) {
      push(@c,$l[$j][$i]);
    }
    # Increment counter if not sorted column result
    $n++ if (join('',@c) ne join('',sort @c));
  }
  return $n;
}

is(sortColomn('swpc','tyad','azbe'),2,'Example 1');
is(sortColomn('cba','daf','ghi'),1,'Example 2');
is(sortColomn('a','b','c'),0,'Example 3');

done_testing;
