#!/usr/bin/env raku
use v6;

sub shiftGrid(@matrix, $k is copy) {
  # get the dimensions of the matrix
  my ($m, $n) = (@matrix.elems, @matrix[0].elems);

  # flatten the matrix
  my @flat = @matrix.flat;

  while ($k-- > 0) {
    @flat.unshift(@flat.pop()); # shift to the right
  }

  # re-matrix the array
  my @result;
  while ($m-- > 0) {
    @result.push(@flat[0..$n-1]);
    @flat.splice(0, $n);
  }

  return @result;
}

sub formatMatrix(@matrix, $indent=19) {
  my @output;
  for @matrix -> @row {
    my $output_row = "[";
    $output_row ~= @row.map({ sprintf "%1d", $_ })
                       .join(', ') ~ "]";
    @output.push($output_row);
  }
  return "[ "
       ~ @output.join(",\n" ~ q{ } x $indent)
       ~ " ]";
}

sub solution(@matrix, $k) {
  say 'Input: @matrix = '~ formatMatrix(@matrix);
  say '       $k = ' ~ $k;
  say 'Output: ' ~ formatMatrix(shiftGrid(@matrix, $k), 10);
}

say "Example 1:";
solution(((1, 2, 3),
          (4, 5, 6),
          (7, 8, 9)), 1);

say "\nExample 2:";
solution(((10, 20),
          (30, 40)), 1);

say "\nExample 3:";
solution(((1, 2),
          (3, 4),
          (5, 6)), 1);

say "\nExample 4:";
solution(((1, 2, 3),
          (4, 5, 6)), 5);

say "\nExample 5:";
solution(((1, 2, 3, 4),), 1);
