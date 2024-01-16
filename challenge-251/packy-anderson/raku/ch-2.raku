#!/usr/bin/env raku
use v6;

sub maxCols(@matrix) {
  my @rotated; # rotate cols to rows
  for @matrix -> @row {
    for @row.kv -> $k, $v {
      @rotated[$k].push($v);
    }
  }
  # return the max of the now rows!
  return @rotated.map({ $_.max() });
}

sub luckyNumber(@matrix) {
  my @minRows = @matrix.map({ $_.min() });
  my @maxCols = maxCols(@matrix);
  return ( @minRows (&) @maxCols ) // -1;
}

sub formatMatrix(@matrix, $indent) {
  my @output;
  for @matrix -> @row {
    my $output_row = q{ } x $indent ~ "  [";
    $output_row ~= @row.map({ sprintf "%2d", $_ })
                       .join(', ') ~ "]";
    @output.push($output_row);
  }
  return "[\n"
       ~ @output.join(",\n")
       ~ "\n"
       ~ q{ } x $indent ~ "]";
}
sub solution(@matrix) {
  say 'Input: $matrix = ' ~ formatMatrix(@matrix, 17);
  my $lucky = luckyNumber(@matrix);
  say "Output: $lucky";
}

say "Example 1:";
solution([ [ 3,  7,  8],
           [ 9, 11, 13],
           [15, 16, 17] ]);

say "\nExample 2:";
solution([ [ 1, 10,  4,  2],
           [ 9,  3,  8,  7],
           [15, 16, 17, 12] ]);

say "\nExample 3:";
solution([ [7, 8],
           [1, 2] ]);
