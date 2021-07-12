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
];

foreach my $t (@$tests) {
  printf "%s\n", join(',', @$t) unless is(invertBit($t->[0],$t->[1]), $t->[2]);
  print "------------\n";
}

done_testing();

sub invertBit($$) {
  my ($m,$n) = @_;

  # upper part + modified bit + lower part
  return (((($m >> $n) << 1 ) + ((($m >> ($n - 1)) & 1 ) ^ 1)) << ($n - 1)) + 
         ($m & (0xff >> (8 - $n + 1))); 
}
