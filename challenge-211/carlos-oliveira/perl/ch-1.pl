use strict;
use warnings;
use v5.36;

use Test::More;
use List::Util qw(uniq);

sub is_toeplitz_matrix (@matrix) {
  my $cols = $matrix[0]->@*;
  for my $i (0..$#matrix) {
    my @diagonal = uniq map { $i < $cols ? $_->[$i++] : () } @matrix;
    return 0 unless @diagonal == 1;
  }
  return 1;
}

is is_toeplitz_matrix(
  [4, 3, 2, 1],
  [5, 4, 3, 2],
  [6, 5, 4, 3]
), 1;
is is_toeplitz_matrix(
  [1, 2, 3],
  [3, 2, 1]
), 0;

done_testing;
