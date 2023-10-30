#!/bin/perl

=pod

The Weekly Challenge - 236
- https://theweeklychallenge.org/blog/perl-weekly-challenge-236

Author: Niels 'PerlBoy' van Dijke

Task 2: Array Loops
Submitted by: Mark Anderson

You are given an array of unique integers.

Write a script to determine how many loops are in the given array.

|| To determine a loop: Start at an index and take the number at array[index]
|| and then proceed to that index and continue this until you end up at the starting index.

=cut

use v5.16;

use common::sense;

use Test::More;

sub arrayLoops (@) {
  my ($n,%u) = (0);

  for my $i (0 .. scalar(@_)-1) {
    next if exists $u{$i};

    my $j = $_[$i];
    while (!exists $u{$j}) {
      last if ($j < 0 or $j >= scalar(@_));
      $j = $u{$j} = $_[$j];
    }

    $n++ if (exists $u{$j});
  }
  return $n;
}

is(arrayLoops(4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10),3);
is(arrayLoops(0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19),6);
is(arrayLoops(0,3,1,2),2);
is(arrayLoops(0,1,5,2),2);
is(arrayLoops(-1),0);

done_testing;
