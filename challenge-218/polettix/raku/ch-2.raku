#!/usr/bin/env raku
use v6;
sub MAIN {
   my @tests =
      [[0, 0, 1, 1], [1, 0, 1, 0], [1, 1, 0, 0]],
      [[0],],
   ;
   put(matrix-score($_)) for @tests;
}

sub matrix-score ($matrix) {
   my $n-rows = $matrix.elems;
   my $threshold = ($n-rows div 2) + ($n-rows % 2);
   for ^$n-rows -> $r {
      toggle-row($matrix, $r) unless $matrix[$r][0];
   }
   for 1 .. $matrix[0].end -> $c {
      toggle-col($matrix, $c) if count-col($matrix, $c) < $threshold;
   }
   return $matrix.map({ $_.join('').parse-base(2) }).sum;
}

sub toggle-row ($m, $r) { $m[$r][$_] = 1 - $m[$r][$_] for 0 .. $m[0].end }

sub toggle-col ($matrix, $c) { $_[$c] = 1 - $_[$c] for @$matrix }

sub count-col ($matrix, $c) { $matrix.map({ $_[$c] }).sum }
