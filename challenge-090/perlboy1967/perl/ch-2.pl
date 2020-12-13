#!/usr/bin/perl

# Perl Weekly Challenge - 090
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-090/
#
# Task 2 Ethiopian Multiplication
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(sum);
use Scalar::Util qw(looks_like_number);

# Unbuffered STDOUT
$|++;

@ARGV = (231, 13)
  unless (@ARGV);

my ($M, $N) = @ARGV;

die "Please provide two integer numbers (x >= 0)"
  unless (looks_like_number($M) and $M =~ m#^[1-9][0-9]*$# and
          looks_like_number($N) and $N =~ m#^[1-9][0-9]*$#);

printf "%d x %d = %d\n", $M, $N, ethiopianMultiply($M,$N);

sub ethiopianMultiply {
  my ($m, $n) = @_;

  my $r;

  while ($m) {
    # Some nice binary operations (and & shift)
    ($r, $m, $n) = ($r += ($m & 1 ? $n : 0), $m >> 1, $n << 1);
  }

  return $r;
} 
