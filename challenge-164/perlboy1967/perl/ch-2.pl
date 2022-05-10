#!/bin/perl

=pod

The Weekly Challenge - 164
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-164/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Happy Numbers
Submitted by: Robert DiCicco

Write a script to find the first 8 Happy Numbers in base 10. For more 
information, please check out Wikipedia.

Starting with any positive integer, replace the number by the sum of the 
squares of its digits, and repeat the process until the number equals 1 
(where it will stay), or it loops endlessly in a cycle which does not include 1.

Those numbers for which this process end in 1 are happy numbers, while those 
numbers that do not end in 1 are unhappy numbers.

=cut

use v5.16;

use List::Util qw(sum);

my ($i,$j) = (0,0);
while ($i < 8) {
  (say $j and $i++) if isHappy(++$j);
}

sub isHappy ($) {
  my ($n) = @_;

  my %seen;

  while ($n != 1 and !exists $seen{$n}) {
    $seen{$n}++;
    $n = sum map { $_*$_ } unpack '(A1)*', $n;
  }

  return $n == 1;
}

