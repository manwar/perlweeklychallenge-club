#!/usr/bin/env perl
use v5.38;

sub submatrixSum(@a) {
  my $M = $#a;       # rows
  my $N = $#{$a[0]}; # columns
  # we are ASSUMING the matrix is consistent with
  # each row having the same number of columns
  my @b;
  foreach my $i ( 0 .. $M - 1 ) {
    push @b, [];
    foreach my $k ( 0 .. $N - 1 ) {
      $b[$i]->[$k] = $a[$i]->[$k]   + $a[$i]->[$k+1]
                   + $a[$i+1]->[$k] + $a[$i+1]->[$k+1];
    }
  }
  return @b;
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

sub solution(@a) {
  say 'Input:  $a = ' . formatMatrix(\@a, 13);
  my @b = submatrixSum(@a);
  say 'Output: $b = ' . formatMatrix(\@b, 13);
}

say "Example 1:";
solution([1,  2,  3,  4],
         [5,  6,  7,  8],
         [9, 10, 11, 12]);

say "\nExample 2:";
solution([1, 0, 0, 0],
         [0, 1, 0, 0],
         [0, 0, 1, 0],
         [0, 0, 0, 1]);
