#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-358#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Max Str Value
Submitted by: Mohammad Sajid Anwar

You are given an array of alphanumeric string, @strings.

Write a script to find the max value of alphanumeric string in the given
array. The numeric representation of the string, if it comprises of digits
only otherwise length of the string.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub maxStrValue (@strings) {
  my ($max,$value,$i) = (0,0);
  for (@strings) {
    if ($_ =~ /^\d+$/) {
      ($i,$value) = (+$_,1);
      $max = $i if ($i > $max);
    } else {
      next if ($value);
    }
    $i = length($_);
    $max = $i if $i > $max;
  }
  return $max;
}

is(maxStrValue(qw{123 45 6}),123,'Example 1');
is(maxStrValue(qw{abc de fghi}),4,'Example 2');
is(maxStrValue(qw{0012 99 a1b2c}),99,'Example 3');
is(maxStrValue(qw{x 10 xyz 007}),10,'Example 4');
is(maxStrValue(qw{hello123 2026 perl}),2026,'Example 5');

done_testing;
