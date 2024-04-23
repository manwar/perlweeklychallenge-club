#! /usr/bin/raku

use Test;

plan 3;

is(xmatrix([[1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1]]), True, 'example 1');
is(xmatrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]]), False, 'example 2');
is(xmatrix([[1, 0, 2], [0, 3, 0], [4, 0, 5]]), True, 'example 3');

sub xmatrix(@a) {
  my $order = @a.elems - 1;
  my $valid = True;
  for (0 .. @a.end) -> $y {
    for (0 .. @a[$y].end) -> $x {
      if ($x == $y || $x == $order - $y) {
        if (@a[$y][$x] == 0) {
          $valid = False;
        }
      } else {
        if (@a[$y][$x] != 0) {
          $valid = False;
        }
      }
      unless ($valid) {
        last;
      }
    }
    unless ($valid) {
      last;
    }
  }
  return $valid;
}
