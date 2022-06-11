#!/bin/perl

=pod

The Weekly Challenge - 157
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-157/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Brazilian Number
Submitted by: Mohammad S Anwar

You are given a number $n > 3.

Write a script to find out if the given number is a Brazilian Number.

 || A positive integer number N has at least one natural number B where 
 || 1 < B < N-1 where the representation of N in base B has same digits.

=cut

use v5.16;

my $n = shift // 13;

foreach my $base (2 .. $n - 2) {
  foreach my $digit (1 .. $base - 1) {
    my ($sum,$pos) = (0,0);
    while ($sum < $n) {
      $sum += $digit * $base**$pos++;
    }
    if ($sum == $n) {
      say "n=$n is a Brazilian Number :: base$base(",join('|',($digit) x $pos),')';
      exit;
    }
  }
}

say "n=$n is NOT a Brazilian Number";
