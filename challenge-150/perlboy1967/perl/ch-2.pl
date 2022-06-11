#!/bin/perl

=pod

The Weekly Challenge - 150
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-150/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Square-free Integer
Submitted by: Mohammad S Anwar

Write a script to generate all square-free integers <= 500.

  | In mathematics, a square-free integer (or squarefree integer) is an 
  | integer which is divisible by no perfect square other than 1. That 
  | is, its prime factorization has exactly one factor for each prime 
  | that appears in it. For example, 10 = 2 x 5 is square-free, but 
  | 18 = 2 x 3 x 3 is not, because 18 is divisible by 9 = 3**2.

=cut

use v5.16;
use strict;

use List::MoreUtils qw(none);
use Data::Printer output => 'stdout';

my @i = (1);

my %isqr = (2 => 4);
my ($i, $m) = (2, 2);

while ($i < 500) {
  if ($i > 2 * $isqr{$m}) {
    $m++;
    $isqr{$m} = $m * $m;
  }
  push(@i, $i) if none{$i % $isqr{$_} == 0} keys %isqr;
  $i++;
}
     
p @i;

