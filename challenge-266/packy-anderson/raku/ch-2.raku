#!/usr/bin/env raku
use v6;

sub isDiagonal($x, $y, $N) {
  return (
    $N == 1 || $N == 2 || $x == $y || $x + $y == $N - 1
  );
}

sub isXMatrix(@matrix) {
  my $N = @matrix.elems;
  for @matrix.kv -> $y, @row {
    for @row.kv -> $x, $value {
      # fail if diagonal values are zero or
      # non-diagonal values are non-zero
      return False
        unless isDiagonal($x, $y, $N) == ($value != 0);
    }
  }
  return True;
}

sub formatMatrix(@matrix, $indent=17) {
  my @output;
  for @matrix -> @row {
    my $output_row = q{ } x $indent ~ "  [";
    $output_row ~= @row.map({ sprintf "%1d", $_ })
                       .join(', ') ~ "]";
    @output.push($output_row);
  }
  return "[\n"
       ~ @output.join(",\n")
       ~ "\n"
       ~ q{ } x $indent ~ "]";
}

sub solution(@matrix) {
  say 'Input: $matrix = ' ~ formatMatrix(@matrix);
  say 'Output: ' ~ isXMatrix(@matrix);
}

say "Example 1:";
solution([
  [1, 0, 0, 2],
  [0, 3, 4, 0],
  [0, 5, 6, 0],
  [7, 0, 0, 1],
]);

say "\nExample 2:";
solution([
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
]);

say "\nExample 3:";
solution([
  [1, 0, 2],
  [0, 3, 0],
  [4, 0, 5],
]);

say "\nExample 4:";
solution([
  [1, 0, 0, 0, 1],
  [0, 1, 0, 1, 0],
  [0, 0, 1, 0, 0],
  [0, 1, 0, 1, 0],
  [1, 0, 0, 0, 1],
]);

say "\nExample 5:";
solution([
  [1, 0, 1, 0, 1],
  [0, 1, 0, 1, 0],
  [0, 0, 1, 0, 0],
  [0, 1, 0, 1, 0],
  [1, 0, 0, 0, 1],
]);

say "\nExample 6:";
solution([
  [1, 1],
  [1, 1],
]);

say "\nExample 7:";
solution([
  [1, 0],
  [1, 1],
]);
