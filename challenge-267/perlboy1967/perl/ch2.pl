#!/bin/perl

=pod

The Weekly Challenge - 267
- https://theweeklychallenge.org/blog/perl-weekly-challenge-267

Author: Niels 'PerlBoy' van Dijke

Task 2: Line Counts
Submitted by: Mohammad Sajid Anwar

You are given a string, $str, and a 26-items array @widths containing
the width of each character from a to z.

Write a script to find out the number of lines and the width of the
last line needed to display the given string, assuming you can only
fit 100 width units on a line.

=cut

use v5.32;
use feature qw(signatures);
use common::sense;

use Test2::V0;

use List::AllUtils qw(mesh);

sub lineCounts ($str,@widths) {
  my %cw = mesh @{['a'..'z']}, @widths;
  my ($lines,$width) = (1,0);
  for (split //,$str) {
    if ($width + $cw{$_} > 100) {
      $width = $cw{$_}; $lines++;
    } else {
      $width += $cw{$_};
    }
  }
  return ($lines,$width);
}

is([lineCounts('abcdefghijklmnopqrstuvwxyz',(10)x26)],
   [3,60],'Example 1');
is([lineCounts('bbbcccdddaaa',4,(10)x25)],
   [2,4],'Example 2');

done_testing;
