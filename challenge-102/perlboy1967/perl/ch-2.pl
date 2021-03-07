#!/usr/bin/perl

# Perl Weekly Challenge - 102
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-102/#TASK2
#
# Task 2 - Hash-counting String
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

@ARGV = (<>)
  unless (scalar @ARGV);

foreach my $n (@ARGV) {
  printf "hashCountingString(%d) = '%s'\n",
         $n, hashCountingString($n);
}


sub hashCountingString {
  my ($n) = @_;

  my $r = '';

  while ($n > 0) {
    $r = ($n > 1 ? $n.'#'.$r : '#'.$r);
    $n -= length($n) + 1;
  }

  return $r;
}
