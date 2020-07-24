#!/usr/bin/perl

# Perl Weekly Challenge - 070
#
# Task 2 - Gray Code Sequence
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

sub genGrayCodeSequence($);

my ($N) = @ARGV;

die "Argument must be a positive number"
  unless ($N =~ m#^\d+$#);

my @g = genGrayCodeSequence($N);

printf q{
Input: $N = %d
Output: [%s]
}, $N, join(', ', @g);

sub genGrayCodeSequence($) {
  my ($N) = @_;

  my @g = (0, 1);

  for my $i (2 .. $N) {
    map { $_ = "0$_" } @g;
    map { m/^.(.*)/; push(@g, "1$1") } reverse @g;
  }

  map { $_ = oct("0b$_") } @g;
}

