#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use PDL;

sub x_matrix($matrix) {
    my $m = pdl($matrix);
    my $diagonal = $m->diagonal(0, 1);
    return unless $diagonal->prod;

    my $antidiagonal = rotate_matrix($m)->diagonal(0, 1);
    return unless $diagonal->prod;

    $diagonal     .= 0;
    $antidiagonal .= 0;
    return if any($m);

    return 1
}

sub rotate_matrix($m) {
    $m->slice([], [-1, 0])
}

use Test::More tests => 3 + 1;

ok x_matrix([ [1, 0, 0, 2],
              [0, 3, 4, 0],
              [0, 5, 6, 0],
              [7, 0, 0, 1],
]), 'Example 1';


ok ! x_matrix([ [1, 2, 3],
                [4, 5, 6],
                [7, 8, 9],
]), 'Example 2';

ok x_matrix([ [1, 0, 2],
              [0, 3, 0],
              [4, 0, 5],
          ]), 'Example 3';

ok ! x_matrix([ [1, 0, 0, 2],
                [0, 3, 4, 0],
                [0, 5, 0, 0],
                [7, 0, 0, 1],
]), 'Zero on a diagonal';
