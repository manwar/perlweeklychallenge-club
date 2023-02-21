use strict;
use warnings;
use v5.36;

use experimental qw(refaliasing);

use Test::More;

sub reshape_matrix ($matrix, $nr, $nc) {
  # get old rows and columns counts
  my $or = $matrix->@*;
  my $oc;
  if (ref $matrix->[0] eq 'ARRAY') {
    $oc = $matrix->[0]->@*;
  } else {
    $oc = 1;
    $matrix = [$matrix];
  }
  return 0 unless $nr * $nc == $or * $oc;
  my @new_matrix;
  my @new_row;
  my $col = 0;
  for \my @row (@$matrix) {
    for my $elem (@row) {
      push @new_row, $elem;
      if (++$col == $nc) {
        push @new_matrix, [@new_row];
        @new_row = ();
        $col = 0;
      }
    }
  }
  return $nr == 1 ? $new_matrix[0] : \@new_matrix;
}

is_deeply reshape_matrix ([ [ 1, 2 ], [ 3, 4 ] ], 1, 4),        [ 1, 2, 3, 4 ];
is_deeply reshape_matrix ([ [ 1, 2, 3 ] , [ 4, 5, 6 ] ], 3, 2), [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ];
is reshape_matrix ([ 1, 2 ], 3, 2),                             0;
is_deeply reshape_matrix ([ [ 1, 2, 3, 4 ] ], 1, 4),            [ 1, 2, 3, 4 ];
is_deeply reshape_matrix ([ 1, 2, 3, 4 ], 2, 2),                [ [ 1, 2 ], [ 3, 4 ] ];

done_testing;
