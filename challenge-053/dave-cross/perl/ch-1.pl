#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

sub print_matrix {
  my ($matrix) = @_;

  for (@$matrix) {
    say '[', join(', ', @$_), ']';
  }
}

sub rotate_matrix {
  my ($matrix, $degrees) = @_;

  die "Must give rotation in degrees\n" unless $degrees;
  die "Must rotate by 90, 180 or 270 degrees\n"
    if $degrees =~ /\D/ or $degrees % 90 or $degrees > 270;

  my $rotated_matrix;

  for (1 .. $degrees / 90) {
    $rotated_matrix = [];
    for my $i (0 .. $#$matrix) {
      for my $j (0 .. $#{$matrix->[$i]}) {
        $rotated_matrix->[$j][$#{$matrix->[$i]} - $i] = $matrix->[$i][$j];
      }
    }
    $matrix = $rotated_matrix;
  }

  return $rotated_matrix;
}

my $input = [
  [1, 2 ,3],
  [4, 5, 6],
  [7, 8, 9],
];
say "Original matrix:";
print_matrix($input);
for (90, 180, 270) {
  say "Rotating by $_ degrees:";
  print_matrix(rotate_matrix($input, $_));
}
