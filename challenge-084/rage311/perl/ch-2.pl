#!/usr/bin/env perl

use 5.030;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

sub mr_anderson ($matrix) {
  my $max_x = $#{$matrix};
  my $max_y = $#{$matrix->[0]};
  return 0 unless $max_x > 0 && $max_y > 0;

  my $one_squares;

  for my $y (0 .. $max_y) {
    for my $x (0 .. $max_x) {
      my $max_size = ($max_y - $y) <= ($max_x - $x) ? $max_y - $y : $max_x - $x;
      for (
        my $y1 = $y + $max_size, my $x1 = $x + $max_size;
        $y1 > $y && $x1 > $x;
        $y1--, $x1--
      ) {
        my $one_square =
             $matrix->[$x][$y]
          && $matrix->[$x][$y1]
          && $matrix->[$x1][$y]
          && $matrix->[$x1][$y1];

        $one_squares += $one_square;
        if ($one_square) {
          say $x1 - $x + 1, 'x', $y1 - $y + 1, ' @ ',
            "$x,$y to $x1,$y1";
        }
      }
    }
  }

  return $one_squares;
}

sub main {
  my $tests = [
    [
      [qw( 1 1 0 1 )],
      [qw( 1 1 0 0 )],
      [qw( 0 1 1 1 )],
      [qw( 1 0 1 1 )],
    ],

    [
      [qw( 1 1 0 1 1 0 1 )],
      [qw( 1 1 0 0 1 0 0 )],
      [qw( 0 1 1 1 1 1 0 )],
      [qw( 1 0 1 1 1 0 1 )],
      [qw( 1 1 0 0 1 0 0 )],
      [qw( 0 1 1 1 1 1 0 )],
    ],

    [
      [qw( 0 1 0 1 )],
      [qw( 1 0 1 0 )],
      [qw( 0 1 0 0 )],
      [qw( 1 0 0 1 )],
    ],
  ];

  say "one squares: ", mr_anderson($_) for $tests->@*;
}

main();


__DATA__

TASK #2 › Find Square
Submitted by: Mohammad S Anwar

You are given matrix of size m x n with only 1 and 0.

Write a script to find the count of squares having all four corners set as 1.
Example 1:

Input: [ 0 1 0 1 ]
       [ 0 0 1 0 ]
       [ 1 1 0 1 ]
       [ 1 0 0 1 ]

Output: 1

Explanation:
There is one square (3x3) in the given matrix with four corners as 1 starts at r=1;c=2.

[ 1 0 1 ]
[ 0 1 0 ]
[ 1 0 1 ]
