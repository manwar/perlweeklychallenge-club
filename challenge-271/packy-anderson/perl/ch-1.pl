#!/usr/bin/env perl
use v5.38;

use List::Util qw( sum );

sub maximumOnes($matrix) {
  my ($maxCount, $maxRow) = (-1, -1);
  foreach my $rowNum ( 0 .. $#{$matrix} ) {
    my @row = @{ $matrix->[$rowNum] };
    my $count = sum @row;
    if ($count > $maxCount) {
      $maxCount = $count;
      $maxRow   = $rowNum;
    }
  }
  # we're displaying rows 1-indexed
  return $maxRow + 1;
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

sub solution($matrix) {
  say 'Input: $matrix = ' . formatMatrix($matrix);
  say 'Output: ' . maximumOnes($matrix);
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
