#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
use List::Util 'sum';

say matrix_score($_) for test_matrixes();

sub matrix_score ($matrix) {
   my $n_rows = $matrix->@*;
   my $threshold = int($n_rows / 2) + ($n_rows % 2);
   for my $r (0 .. $n_rows - 1) {
      toggle_row($matrix, $r) unless $matrix->[$r][0];
   }
   for my $c (1 .. $matrix->[0]->$#*) {
      toggle_col($matrix, $c) if count_col($matrix, $c) < $threshold;
   }
   return sum(map { binarr_to_dec($_) } $matrix->@*);
}

sub binarr_to_dec ($row) {
   my $v = 0;
   $v = ($v << 1) | ($row->[$_] ? 1 : 0) for 0 .. $row->$#*;
   return $v;
}

sub toggle_row ($m, $r) {
   $m->[$r][$_] = 1 - $m->[$r][$_] for 0 .. $m->[$r]->$#*;
}

sub toggle_col ($matrix, $c) { $_->[$c] = 1 - $_->[$c] for $matrix->@* }

sub count_col ($m, $c) { sum(map { $_->[$c] ? 1 : 0 } $m->@*) // 0 }

sub test_matrixes {
   return (
      [[0, 0, 1, 1], [1, 0, 1, 0], [1, 1, 0, 0]],
      [[0]],
   );
}
