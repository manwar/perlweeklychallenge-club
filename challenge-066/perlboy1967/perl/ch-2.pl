#!/usr/bin/perl

# Perl Weekly Challenge - 066
#
# Task 2 - Power Integers
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;
use Data::Dumper;

my ($N) = @ARGV;
die "Only posive number allowed" if (defined $N and $N < 1);

sub findPowers ($);

my @test;

if (defined $N) {
  @test = ($N);
} else {
  @test = (9, 45, 128);
}

foreach my $t (@test) {
  printf "The power integers of %d is/are: %s\n",
    $t, join(', ', findPowers($t));
}

sub findPowers ($) {
  my ($n) = @_;

  my @p;

  for my $p (2 .. int(sqrt($n))) {
    if (int(log($n)/log($p)) == log($n)/log($p)) {
      push(@p, sprintf('%d^%d', $p, int(log($n)/log($p))));
    }
  }

  push(@p, "$n^1");

  return @p;
}
   
   

