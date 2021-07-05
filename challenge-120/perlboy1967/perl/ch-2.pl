#!/usr/bin/perl

# Perl Weekly Challenge - 120
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-120/#TASK2
#
# Task 2 - Clock Angle
#
# Author: Niels 'PerlBoy' van Dijke
#

use v5.16;
use strict;
use warnings;

use List::Util qw(min);

# Prototype(s)
sub clockAngle($);

use Test::More;

my $tests = [ 
   [    '03:10',  35],
   [    '04:00', 120],
   [    '12:12',  66],
   [    '05:30',  15],
];

foreach my $t (@$tests) {
  printf "%s\n", join(',', @$t) unless is(clockAngle($t->[0]), $t->[1]);
}

done_testing();


sub clockAngle($) {
  my @t = split(/:/, $_[0]);

  $t[0] = ($t[0] % 12 + $t[1]/60) * 30;
  $t[1] *= 6;

  return min(abs($t[0]-$t[1]),abs($t[1]-$t[0]));
}

