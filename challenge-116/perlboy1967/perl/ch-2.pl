#!/usr/bin/perl

# Perl Weekly Challenge - 116
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-116/#TASK2
#
# Task 2 - Sum of Squares
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::Util qw(sum);

use Test::More;

# Prototype(s)
sub isSumOfSquares($);

my %tests = (
   34 => 1,
   50 => 1,
   52 => 0,
   2021 => 1,
   1234563 => 1,
);

my %iSqr = (0,0);

foreach my $test (sort keys %tests) {
  is(isSumOfSquares($test),$tests{$test});
}

done_testing;


sub isSumOfSquares($) {
  my ($n) = @_;

  return isIntSqr(sum(map{$_**2}split(//,$n)));
}


sub isIntSqr ($) {
  my ($i) = @_;

  state $maxSqr //= $iSqr{0};

  return 1 if (defined $iSqr{$i});
  return 0 if ($maxSqr > $i);

  my ($m,$sqr) = ($iSqr{$maxSqr});
  do {
    $sqr = ++$m**2;
    $iSqr{$sqr} = $m;
  } while ($iSqr{$sqr} <= $i);

  $maxSqr = $sqr;

  return 1 if (defined $iSqr{$i});
  return 0;
}
