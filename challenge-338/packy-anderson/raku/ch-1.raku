#!/usr/bin/env raku
use v6;

sub highestRow(@matrix) {
  @matrix.map({ $_.sum }).max
}

sub solution(@matrix) {
  my $m = @matrix.map({ '[' ~ $_.join(', ') ~ ']'})
                 .join(",\n                  ");
  say "Input: \@matrix = ($m)";
  say "Output: {highestRow(@matrix)}";
}

say "Example 1:";
solution([[4,  4, 4, 4],
          [10, 0, 0, 0],
          [2,  2, 2, 9]]);

say "\nExample 2:";
solution([[1, 5],
          [7, 3],
          [3, 5]]);

say "\nExample 3:";
solution([[1, 2, 3],
          [3, 2, 1]]);

say "\nExample 4:";
solution([[2, 8, 7],
          [7, 1, 3],
          [1, 9, 5]]);

say "\nExample 5:";
solution([[10, 20,  30],
          [5,  5,   5],
          [0,  100, 0],
          [25, 25,  25]]);
