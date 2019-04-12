#!/usr/bin/env perl6

use v6;

subset Count of Int where * >= 3;

#| Generates a single row of the triangle.
multi sub generate-row(Int $n) {
  my @row = [1];

  for 1..^$n -> $m {
    my $fr = ($n - $m) / $m;
    @row.push: @row.tail * $fr;
  }

  @row;
}

#| Generate Pascal's Triangle
sub MAIN(
  Count :$rows = 3 #= Number of rows to make (minimum 3).
) {
  generate-row($_).put for 1..$rows;
}
