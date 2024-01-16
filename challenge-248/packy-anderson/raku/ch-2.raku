#!/usr/bin/env raku
use v6;

sub submatrixSum(@a) {
  # subtract 1 because we're 0-indexed
  my $M = @a.elems - 1;    # rows
  my $N = @a[0].elems - 1; # columns
  # we are ASSUMING the matrix is consistent with
  # each row having the same number of columns
  my @b;
  for 0 .. $M - 1 -> $i {
    for 0 .. $N - 1 -> $k {
      @b[$i;$k] = @a[$i;  $k] + @a[$i;  $k+1]
                + @a[$i+1;$k] + @a[$i+1;$k+1];
    }
  }
  return @b;
}

sub formatMatrix(@matrix, $indent) {
  my @output;
  for @matrix -> @row {
    my $output_row = q{ } x $indent ~ "  [";
    $output_row ~= @row.join(', ') ~ "]";
    @output.push($output_row);
  }
  return "[\n"
       ~ @output.join(",\n")
       ~ "\n"
       ~ q{ } x $indent ~ "]";
}

sub solution(@a) {
  say 'Input:  $a = ' ~ formatMatrix(@a, 13);
  my @b = submatrixSum(@a);
  say 'Output: $b = ' ~ formatMatrix(@b, 13);
}

say "Example 1:";
solution([
            [1,  2,  3,  4],
            [5,  6,  7,  8],
            [9, 10, 11, 12]
         ]);

say "\nExample 2:";
solution([
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
         ]);
