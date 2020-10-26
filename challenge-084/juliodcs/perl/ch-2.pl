use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub all_ones($matrix, $x, $y, $size) {
    return $matrix->[$x        ][$y        ]
        && $matrix->[$x+$size-1][$y        ]
        && $matrix->[$x        ][$y+$size-1]
        && $matrix->[$x+$size-1][$y+$size-1];
}

sub count_squares($matrix) {
    my $count = 0;

    my $h = @{ $matrix };
    my $w = @{ $matrix->[0] };
    my $max = $h > $w ? $h : $w;
    
    for my $s (2 .. $max) {
        for my $y (0 .. $w - $s) {
            for my $x (0 .. $h - $s) {
                $count++ if all_ones($matrix, $x, $y, $s);
            }
        }
    }
    
    return $count;
}

use Test::More;

is count_squares([[1, 1], [1, 1]]), 1, 'Simple matrix';
is count_squares([[1, 1], [1, 0]]), 0, 'Simple matrix, incomplete';
is count_squares([[1, 1], [1, 0], [1, 1], [1, 1]]), 1, 'Simple (w != h) matrix';
is count_squares([[1, 1], [1, 1], [1, 1], [1, 1]]), 3, 'Simple (w != h) matrix, all complete';
is count_squares([[0, 1, 0, 1], [0, 0, 1, 0], [1, 1, 0, 1], [1, 0, 0, 1]]), 1, 'Example test 1';
is count_squares([[1, 1, 0, 1], [1, 1, 0, 0], [0, 1, 1, 1], [1, 0, 1, 1]]), 4, 'Example test 2';
is count_squares([[0, 1, 0, 1], [1, 0, 1, 0], [0, 1, 0, 0], [1, 0, 0, 1]]), 0, 'Example test 3';

done_testing;
