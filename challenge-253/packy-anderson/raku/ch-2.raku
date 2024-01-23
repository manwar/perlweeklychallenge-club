#!/usr/bin/env raku
use v6;

sub weakestRows(@matrix) {
  my @oneCount = @matrix.map({ $_.sum });
  my @weakest = (0 .. @oneCount.end).sort: {
    # sort by count first
    @oneCount[$^a] <=> @oneCount[$^b]
    ||
    # then by index order
    $^a <=> $^b
  };

  return @weakest;
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

sub solution(@matrix) {
  say 'Input: $matrix = ' ~ formatMatrix(@matrix, 17);
  my @output = weakestRows(@matrix);
  say 'Output: (' ~ @output.join(', ') ~ ')';
}

say "Example 1:";
solution([
           [1, 1, 0, 0, 0],
           [1, 1, 1, 1, 0],
           [1, 0, 0, 0, 0],
           [1, 1, 0, 0, 0],
           [1, 1, 1, 1, 1]
         ]);

say "\nExample 2:";
solution([
           [1, 0, 0, 0],
           [1, 1, 1, 1],
           [1, 0, 0, 0],
           [1, 0, 0, 0]
         ]);
