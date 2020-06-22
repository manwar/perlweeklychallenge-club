#!/usr/bin/perl

# Perl Weekly Challenge - 066
#
# Task 1 - Divide Integers
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;
use Data::Dumper;

sub altDivide ($$);

my ($M, $N) = @ARGV;
die "Can't devide by zero" if (defined $N and $N == 0);

my @test;

if (defined $M) {
  @test = ([$M, $N]) 
} else {
  @test = (
    [5, 2], [-5, 2], [-5, -2], [5, -2], 
    [6, 3], [-6, 2], [-6, -2], [6, -2],
  );
}

foreach my $t (@test) {
  ($M, $N) = @$t;
  my ($D, $R) = altDivide($M, $N);
  if ($R) {
    printf "Division of %d by %d = %d, rest %d\n", $M, $N, $D, $R;
  } else {
    printf "Division of %d by %d = %d\n", $M, $N, $D, $R;
  }
}


sub altDivide ($$) {
  my ($M, $N) = @_;

  my ($D, $R) = (0, 0);

  return ($D, $R) if ($M == 0);

  if (0) {
  } elsif ($M > 0 and $N > 0) {
    # Positive number divided by positive number OK
    while ($M - $N >= 0) { $M -= $N; $D++; } $R = $M;
  } elsif ($M > 0 and $N < 0) {
    # Positive number divided by negative number OK
    while ($M + $N >= 0) { $M += $N; $D--; } $R = $M;
  } elsif ($M < 0 and $N > 0) {
    # Negative number divided by positive number
    while ($M + $N <= 0) { $M += $N; $D--; } $R = -$M;
  } elsif ($M < 0 and $N < 0) {
    # Negative number divided by negative number
    while ($M - $N <= 0) { $M -= $N; $D++; } $R = -$M;
  }
  
   return ($D, $R);
}
