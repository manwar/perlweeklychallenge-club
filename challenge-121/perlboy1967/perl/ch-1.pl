#!/usr/bin/perl

# Perl Weekly Challenge - 121
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-121/#TASK1
#
# Task 1 - Invert Bit
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Test::More;

# Prototype(s)
sub invertBit($$);

my $tests = [ 
   [ 12, 3,  8],
   [ 18, 4, 26],
   [ 0b10101010, 5, 0b10111010 ],
   [ 0b111111111111, 8, 0b111101111111 ],
];

foreach my $t (@$tests) {
  printf "%s\n", join(',', @$t) unless is(invertBit($t->[0],$t->[1]), $t->[2]);
}

done_testing();

sub invertBit($$) {
  my ($m,$n) = @_;

  return $m ^ (1 << ($n-1));
}
