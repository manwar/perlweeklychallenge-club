#!/usr/bin/env perl
use v5.38;

use List::Util qw( sum );

sub weakestRows(@matrix) {
  my @oneCount = map { sum(@$_) } @matrix;
  my @weakest = sort {
    # sort by count first
    $oneCount[$a] <=> $oneCount[$b]
    ||
    # then by index order
    $a cmp $b
  } (0 .. $#oneCount);

  return @weakest;
}

sub formatMatrix($matrix, $indent) {
  my @output;
  foreach my $row ( @$matrix ) {
    my $output_row = q{ } x $indent . "  [";
    $output_row .= join(', ', @$row) . "]";
    push @output, $output_row;
  }
  return "[\n"
       . join(",\n", @output)
       . "\n"
       . q{ } x $indent . "]";
}

sub solution(@matrix) {
  say 'Input: $matrix = ' . formatMatrix(\@matrix, 17);
  my @output = weakestRows(@matrix);
  say 'Output: (' . join(', ', @output) . ')';
}

say "Example 1:";
solution(
           [1, 1, 0, 0, 0],
           [1, 1, 1, 1, 0],
           [1, 0, 0, 0, 0],
           [1, 1, 0, 0, 0],
           [1, 1, 1, 1, 1]
         );

say "\nExample 2:";
solution(
           [1, 0, 0, 0],
           [1, 1, 1, 1],
           [1, 0, 0, 0],
           [1, 0, 0, 0]
         );