#!/usr/bin/perl

# Perl Weekly Challenge - 119
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-119/#TASK1
#
# Task 1 - Swap Nibbles
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Test::More;

# Prototype(s)
sub swapNibble($);

my $tests = [ 
   [101,  86],
   [ 18,  33],
   [123, 183],
   [136, 136],
];

foreach my $t (@$tests) {
  printf "%s\n", join(',', @$t) unless is(swapNibble($t->[0]), $t->[1]);
}

done_testing();

sub swapNibble($) {
  return (($_[0] & 0x0f) << 4) + 
         (($_[0] & 0xf0) >> 4);
}
