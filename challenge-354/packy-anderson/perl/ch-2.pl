#!/usr/bin/env perl
use v5.40;

sub shiftGrid($matrix, $k) {
  # get the dimensions of the matrix
  my ($m, $n) = (scalar(@$matrix), scalar(@{$matrix->[0]}));

  # flatten the matrix
  my @flat = map { @{$_} } @$matrix;

  while ($k-- > 0) {
    unshift @flat, pop @flat; # shift to the right
  }

  # re-matrix the array
  my @result;
  while ($m-- > 0) {
    push @result, [ @flat[0..$n-1] ];
    splice @flat, 0, $n;
  }

  return \@result;
}

sub formatMatrix($matrix, $indent=19) {
  my @output;
  foreach my $row (@$matrix) {
    push @output, "[" 
                . join(', ', map { sprintf "%1d", $_ } @$row)
                . "]";
  }
  return "[ "
       . join(",\n" . q{ } x $indent, @output)
       . " ]";
}

sub solution($matrix, $k) {
  say 'Input: @matrix = ' . formatMatrix($matrix);
  say '       $k = ' . $k;
  say 'Output: ' . formatMatrix(shiftGrid($matrix, $k), 10);
}

say "Example 1:";
solution([[1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]], 1);

say "\nExample 2:";
solution([[10, 20],
          [30, 40]], 1);

say "\nExample 3:";
solution([[1, 2],
          [3, 4],
          [5, 6]], 1);

say "\nExample 4:";
solution([[1, 2, 3],
          [4, 5, 6]], 5);

say "\nExample 5:";
solution([[1, 2, 3, 4]], 1);
