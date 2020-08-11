#!/usr/bin/perl

# Perl Weekly Challenge - 068
#
# Task 1 - Zero Matrix
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(min);

sub zeroMatrix (\@);
sub printMatrix ($\@);

my @matrixes = (
  [
    [1, 0, 1],
    [1, 1, 1],
    [1, 1, 1]
  ],
  [
    [1, 0, 1],
    [1, 1, 1],
    [1, 0, 1]
  ]
);

foreach my $matrix (@matrixes) {
  printMatrix('Input', @$matrix);
  zeroMatrix(@$matrix);
  printMatrix('Output', @$matrix);
}

sub zeroMatrix (\@) {
  my ($matrix) = @_;

  map { $_ = [map {0} @$_] if (!min @$_); } @$matrix;
}

sub printMatrix ($\@) {
  my ($label, $matrix) = @_;

  print "$label:\n";
  foreach my $row (@$matrix) {
    printf "[%s]\n", join(', ',@$row);
  }
  print "--------------\n";
}
