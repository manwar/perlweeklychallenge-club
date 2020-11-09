#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;
use List::Util qw/min/;

sub corners {
  my ($matrix, $upper, $left, $size) = @_;
  return $matrix->[$upper][$left] == 1
    && $matrix->[$upper + $size][$left] == 1
    && $matrix->[$upper][$left + $size] == 1
    && $matrix->[$upper + $size][$left + $size] == 1;
}

sub task2 {
  my $matrix = \@_;
  my $m = @$matrix;
  my $n = @{$matrix->[0]};
  my $count = 0;
  my $maxsize = min($m, $n);
  # $size 1 == 2x2 square
  for (my $size = 1; $size < $maxsize; $size += 1) {
    for (my $upper = 0; $upper < $m - $size; $upper += 1) {
      for (my $left = 0; $left < $n - $size; $left += 1) {
        if (corners $matrix, $upper, $left, $size) {
          $count += 1;
        }
      }
    }
  }
  say $count;
}

task2 [ 0, 1, 0, 1 ],
  [ 0, 0, 1, 0 ],
  [ 1, 1, 0, 1 ],
  [ 1, 0, 0, 1 ];

task2 [ 1, 1, 0, 1 ],
  [ 1, 1, 0, 0 ],
  [ 0, 1, 1, 1 ],
  [ 1, 0, 1, 1 ];

task2 [ 0, 1, 0, 1 ],
  [ 1, 0, 1, 0 ],
  [ 0, 1, 0, 0 ],
  [ 1, 0, 0, 1 ];
