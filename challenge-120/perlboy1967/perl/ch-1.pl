#!/usr/bin/perl

# Perl Weekly Challenge - 120
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-120/#TASK1
#
# Task 1 - Swap Odd/Even bits
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Test::More;

# Prototype(s)
sub swapBits($);

my $tests = [ 
   [101, 154],
   [ 18,  33],
];

foreach my $t (@$tests) {
  printf "%s\n", join(',', @$t) unless is(swapBits($t->[0]), $t->[1]);
}

done_testing();

sub swapBits($) {

  $b = sprintf('%08b', $_[0]);
  $b =~ s#(.)(.)#$2$1#g; 

  return oct('0b'.$b);
}
