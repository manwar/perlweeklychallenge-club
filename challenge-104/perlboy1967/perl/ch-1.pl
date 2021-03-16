#!/usr/bin/perl

# Perl Weekly Challenge - 104
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-104/#TASK1
#
# Task 1 - FUSC Sequence
#
# Author: Niels 'PerlBoy' van Dijke
#

use v5.16;
use strict;
use warnings;

use Memoize;

# Prototype
sub fusc($);

memoize('fusc');

printf "%s\n", join(', ', map { fusc($_) } (0 .. 49));


sub fusc ($) {
  my ($n) = @_;

  return $n if ($n < 2);

  if (($n % 2) == 0) {
    return fusc($n/2);
  } else {
    return fusc(($n-1)/2) + fusc(($n+1)/2);
  }
}
