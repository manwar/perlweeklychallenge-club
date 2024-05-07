#!/usr/bin/env perl
use v5.38;

sub isDiagonal($x, $y, $N) {
  return (
    $N == 1 || $N == 2 || $x == $y || $x + $y == $N - 1
  );
}

sub isXMatrix(@matrix) {
  my $N = scalar @matrix;
  foreach my $y ( 0 .. $#matrix ) {
    my @row = @{$matrix[$y]};
    foreach my $x ( 0 .. $#row ) {
      my $value = $row[$x];
      # fail if diagonal values are zero or
      # non-diagonal values are non-zero
      return 0
        unless isDiagonal($x, $y, $N) == ($value != 0);
    }
  }
  return 1;
}

sub formatMatrix($matrix, $indent=17) {
  my @output;
  foreach my $row (@$matrix) {
    my $output_row = q{ } x $indent . "  [";
    $output_row .= join(', ', map { sprintf "%1d", $_ } @$row) . ']';
    push @output, $output_row;
  }
  return "[\n"
       . join(",\n", @output)
       . "\n"
       . q{ } x $indent . "]";
}

sub solution(@matrix) {
  say 'Input: $matrix = ' . formatMatrix(\@matrix);
  say 'Output: ' . (isXMatrix(@matrix) ? 'True' : 'False');
}

say "Example 1:";
solution(
  [1, 0, 0, 2],
  [0, 3, 4, 0],
  [0, 5, 6, 0],
  [7, 0, 0, 1],
);

say "\nExample 2:";
solution(
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
);

say "\nExample 3:";
solution(
  [1, 0, 2],
  [0, 3, 0],
  [4, 0, 5],
);

say "\nExample 4:";
solution(
  [1, 0, 0, 0, 1],
  [0, 1, 0, 1, 0],
  [0, 0, 1, 0, 0],
  [0, 1, 0, 1, 0],
  [1, 0, 0, 0, 1],
);

say "\nExample 5:";
solution(
  [1, 0, 1, 0, 1],
  [0, 1, 0, 1, 0],
  [0, 0, 1, 0, 0],
  [0, 1, 0, 1, 0],
  [1, 0, 0, 0, 1],
);

say "\nExample 6:";
solution(
  [1, 1],
  [1, 1],
);

say "\nExample 7:";
solution(
  [1, 0],
  [1, 1],
);
