#!/usr/bin/env raku
use v6;

sub maximumOnes(@matrix) {
  my ($maxCount, $maxRow) = (-1, -1);
  for @matrix.kv -> $rowNum, @row {
    my $count = [+] @row;
    if ($count > $maxCount) {
      $maxCount = $count;
      $maxRow   = $rowNum;
    }
  }
  # we're displaying rows 1-indexed
  return $maxRow + 1;
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
  say 'Output: ' ~ maximumOnes(@matrix);
}

say "Example 1:";
solution([ [0, 1],
           [1, 0] ]);

say "\nExample 2:";
solution([ [0, 0, 0],
           [1, 0, 1] ]);

say "\nExample 3:";
solution([ [0, 0],
           [1, 1],
           [0, 0] ]);
