#!/usr/bin/env perl
use v5.38;

use Array::Utils qw( intersect );
use List::Util qw( min max );

sub maxCols(@matrix) {
  my @rotated; # rotate cols to rows
  foreach my $row ( @matrix ) {
    foreach my $k ( 0 .. $#{$row} ) {
      my $v = $row->[$k];
      push @{$rotated[$k]}, $v;
    }
  }
  # return the max of the now rows!
  return map { max( @$_ ) } @rotated;
}

sub luckyNumber(@matrix) {
  my @minRows = map { min( @$_ ) } @matrix;
  my @maxCols = maxCols(@matrix);
  # intersect() returns an array, so get the first element
  return (intersect( @minRows, @maxCols ))[0] // -1;
}

sub formatMatrix(@matrix) {
  my $indent = 17;
  my @output;
  foreach my $row ( @matrix ) {
    my $output_row = q{ } x $indent . "  [";
    $output_row .= join(', ', map { sprintf "%2d", $_ } @$row);
    push @output, $output_row;
  }
  return "[\n"
       . join(",\n", @output)
       . "\n"
       . q{ } x $indent . "]";
}
sub solution(@matrix) {
  say 'Input: $matrix = ' . formatMatrix(@matrix);
  my $lucky = luckyNumber(@matrix);
  say "Output: $lucky";
}

say "Example 1:";
solution([ 3,  7,  8],
         [ 9, 11, 13],
         [15, 16, 17]);

say "\nExample 2:";
solution([ 1, 10,  4,  2],
         [ 9,  3,  8,  7],
         [15, 16, 17, 12]);

say "\nExample 3:";
solution([7, 8],
         [1, 2]);
