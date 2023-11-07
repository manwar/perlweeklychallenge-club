#!/usr/bin/env perl
use v5.38;

sub flipMatrix {
  my(@matrix) = @_;
  foreach my $subarray ( @matrix ) {
    $subarray = [ map { abs($_ - 1) } reverse @$subarray ];
  }
  return @matrix;
}

sub formatArray {
  my(@matrix) = @_;
  my @formatted;
  foreach my $subarray ( @matrix ) {
    push @formatted, '[' . join(', ', @$subarray) . ']';
  }
  return '(' . join(', ', @formatted) . ')';
}

sub solution {
  my(@matrix) = @_;
  say 'Input: @matrix = ' . formatArray(@matrix);
  my @output = flipMatrix(@matrix);
  say 'Output: ' . formatArray(@output);
}

say "Example 1:";
solution([1, 1, 0], [1, 0, 1], [0, 0, 0]);

say "\nExample 2:";
solution([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]);