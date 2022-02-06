#!/bin/perl

=pod

The Weekly Challenge - 150
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-150/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Fibonacci Words
Submitted by: Mohammad S Anwar

You are given two strings having same number of digits, $a and $b.

Write a script to generate Fibonacci Words by concatenation of the
previous two strings. Finally print 51st digit of the first term having 
at least 51 digits.

=cut

use v5.16;
use strict;
use constant LEN => 51;

# Prototype
sub fibStr ($$$);


@ARGV = (1234, 5678) unless @ARGV == 2;

my ($i, $f) = (1);
$f = fibStr($ARGV[0], $ARGV[1], $i++) while (length($f) < LEN);

printf "The %dth digit in the first having at least 51 digits '%s' is '%s'\n",
       LEN, $f, substr($f, LEN-1, 1);


sub fibStr ($$$) {
  my ($s1, $s2, $n) = @_;

  state $s = [$s1, $s2];

  $s->[@$s] = $s->[@$s-2] . $s->[@$s-1] while (@$s < $n);

  return $s->[$n-1]
}

