#!/usr/bin/perl

# Perl Weekly Challenge - 123
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-123/#TASK1
#
# Task 1 - Ugly Numbers
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::Util qw(min);

use Test::More;

# Prototype(s)
sub uglyNumberN($);


my $tests = [ 
   [  1, 1 ],
   [  2, 2 ],
   [  3, 3 ],
   [  4, 4 ],
   [  5, 5 ],
   [  6, 6 ],
   [  6, 6 ],
   [  7, 8 ],
   [  9, 10],
   [ 10, 12],
   [100, 1536],
];

foreach my $t (@$tests) {
  is(uglyNumberN($t->[0]),$t->[1]);
}

done_testing();

#
# Blatenly 'borrowed' solution using Dynamic Programming from:
# https://www.codesdope.com/blog/article/ugly-numbers/
#
sub uglyNumberN($) {
  my ($n) = @_;

  my @uN = (1);

  # indices for multiples of 2,3,5 respectively
  my ($u2, $u3, $u5) = (0,0,0);

  # initial multiple value
  my ($m2, $m3, $m5) = (2,3,5);

  for my $i (1 .. $n - 1) {
    $uN[$i] = min($m2, $m3, $m5);

    $m2 = $uN[++$u2] * 2 if ($uN[$i] == $m2);
    $m3 = $uN[++$u3] * 3 if ($uN[$i] == $m3);
    $m5 = $uN[++$u5] * 5 if ($uN[$i] == $m5);
  }

  return $uN[$n-1];
}

