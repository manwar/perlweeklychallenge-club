#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use PDL;

sub shift_grid($matrix, $k) {
    my $pdl = pdl($matrix);
    my $length = $pdl->nelem;
    my $steps = $k % $length;
    return $pdl->unpdl if 0 == $steps;

    my ($x, $y) = $pdl->dims;
    my $flt = $pdl->flat;
    return $flt->slice([$length - $steps, $length - 1])
        ->append($flt->slice([0, $length - $steps - 1]))->reshape($x, $y)
        ->unpdl
}

use Test2::V0 qw{ is plan };
plan(5 + 2);

is shift_grid([[1, 2, 3],
               [4, 5, 6],
               [7, 8, 9]], 1),
    [[9, 1, 2],
     [3, 4, 5],
     [6, 7, 8]], 'Example 1';

is shift_grid([[10, 20],
               [30, 40]], 1),
    [[40, 10],
     [20, 30]], 'Example 2';

is shift_grid([[1, 2],
               [3, 4],
               [5, 6]], 1),
    [[6, 1],
     [2, 3],
     [4, 5]], 'Example 3';

is shift_grid([[1, 2, 3],
               [4, 5, 6]], 5),
    [[2, 3, 4],
     [5, 6, 1]], 'Example 4';

is shift_grid([[1, 2, 3, 4]], 1),
    [[4, 1, 2, 3]],
    'Example 5';


is shift_grid([[1, 2, 3],
               [4, 5, 6]], 6),
    [[1, 2, 3],
     [4, 5, 6]],
    'Roundtrip';

is shift_grid([[1, 2, 3],
               [4, 5, 6]], 13),
    [[6, 1, 2],
     [3, 4, 5]],
    'Several times around';
