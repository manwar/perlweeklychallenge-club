use strict;
use warnings;
use feature qw(say state);
use experimental 'signatures';

sub count_squares($matrix) {
    my $h = @{ $matrix };
    my $w = @{ $matrix->[0] };
    my $sq_size = $h < $w ? $h : $w;
    
    my $_all_ones = sub($y, $x, $size) {
        return $matrix->[$y        ][$x        ]
            && $matrix->[$y+$size-1][$x        ]
            && $matrix->[$y        ][$x+$size-1]
            && $matrix->[$y+$size-1][$x+$size-1] ? 1 : 0;
    };
    
    my $_count_squares;
    $_count_squares = sub($size, $y, $x, $acc) {
        return $size > $sq_size ? $acc
            :  $y > $h - $size  ? $_count_squares->($size + 1, 0, 0, $acc)
            :  $x > $w - $size  ? $_count_squares->($size, $y + 1, 0, $acc)
            :  $_count_squares->($size, $y, $x + 1, $acc + $_all_ones->($y, $x, $size));
    };

    return $_count_squares->(2, 0, 0, 0);
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
