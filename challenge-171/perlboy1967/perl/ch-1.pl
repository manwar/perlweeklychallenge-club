#!/bin/perl

=pod

The Weekly Challenge - 171 - Task 1
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-171/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Abundant Number
Submitted by: Mohammad S Anwar

Write a script to generate first 20 Abundant Odd Numbers.

According to wikipedia,

 || A number n for which the sum of divisors σ(n) > 2n, or, equivalently, 
 || the sum of proper divisors (or aliquot sum) s(n) > n.

=cut

use v5.16;
use warnings;

use List::Util qw(sum0);
use Math::Factor::XS qw(factors);

# Prototype(s)
sub isOddAbudant ($);


my ($i,$n) = (1,1);
while ($i <= 20) {
  if (isOddAbudant($n)) {
    say "$i\t$n"; $i++;
  }
  $n += 2;
}


sub isOddAbudant ($) {
  return $_[0] % 2 && sum0(factors($_[0])) > $_[0];
}
