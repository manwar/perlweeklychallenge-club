#!/usr/bin/perl

use strict;
use warnings;
use feature qw[signatures say];
no warnings 'experimental::signatures';

use List::Util 'min';

my $matrix = get_matrix();

say count_squares($matrix);

sub count_squares($matrix) {
  my $count = 0;
  my $size  = @$matrix;

  for my $r (0 .. $size - 1) {
    for my $c (0 .. $size - 1) {
      for my $edge (1 .. min($size - $r, $size - $c)) {
        $count++ if good_square($matrix, $r, $c, $edge);
      }
    }
  }

  return $count;
}

sub good_square($matrix, $r, $c, $edge) {
  return if ! $matrix->[$r        ][$c];
  return if ! $matrix->[$r + $edge][$c];
  return if ! $matrix->[$r + $edge][$c + $edge];
  return if ! $matrix->[$r        ][$c + $edge];
  return 1;
}

sub get_matrix() {
  while (<>) {
    chomp;
    push @$matrix, [ grep { /^0|1$/ } split ];
  }

  my $size = @$matrix;
  die "Not a square matrix\n" if grep { @$_ ne $size } @$matrix;

  return $matrix;
}
