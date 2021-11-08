#!/usr/bin/perl

# Perl Weekly Challenge - 114
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-114/#TASK1
#
# Task 1 - Next Palindrome Number
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Test::More;

# Prototype(s)
sub nextPalindromeNumber($);

my %tests = (1234 => 1331, 999 => 1001, 54321 => 54345);

foreach my $test (keys %tests) {
  is(nextPalindromeNumber($test), $tests{$test});
}

done_testing;

sub nextPalindromeNumber($) {
  my ($n) = @_;

  do {
    $n++;
  } while ($n != reverse scalar $n); 

  return $n;
}

