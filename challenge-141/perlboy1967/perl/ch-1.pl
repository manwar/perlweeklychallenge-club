#!/bin/perl

=pod

The Weekly Challenge - 140
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-140/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Number Divisors
Submitted by: Mohammad S Anwar

Write a script to find lowest 10 positive integers having exactly 8 divisors.

=cut

use v5.16;
use strict;
use warnings;

use Data::Printer output => 'stdout';

sub hasNDivisors($$);

my $n = 24;
my @n;

while (scalar(@n) < 10) {
  if (hasNDivisors($n,8)) {
    push(@n,$n);
  }
  $n++;
}

p @n;


sub hasNDivisors($$) {
  my ($n,$count) = @_;

  my $i = 1;
  my @d = ($i);
  while ($i < $n) {
    push(@d,$i) if ($n % $i == 0);
    $i++;
  }

  return (scalar(@d) == $count);
}
