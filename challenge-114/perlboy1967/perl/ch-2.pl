#!/usr/bin/perl

# Perl Weekly Challenge - 114
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-114/#TASK2
#
# Task 2 - HigherIntegerSetBits
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Test::More;

# Prototype(s)
sub higherIntegerSetBits($);

my %tests = (3 => 5, 12 => 17, 127 => 191, 666 => 668);

foreach my $test (keys %tests) {
  is(higherIntegerSetBits($test), $tests{$test});
}

done_testing;

sub higherIntegerSetBits($) {
  my ($n) = @_;

  my $nBitsSet = scalar(grep/1/,split(//,sprintf('%b',$n)));
  do {
    $n++;
  } while ($nBitsSet != scalar(grep/1/,split(//,sprintf('%b',$n)))); 

  return $n;
}

