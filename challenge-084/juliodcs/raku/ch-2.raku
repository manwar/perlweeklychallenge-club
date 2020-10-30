#! /usr/bin/raku

sub count-squares(\matrix where matrix.elems > 1 && matrix.head.elems > 1) {
    sub all-ones(\y, \x, \size) {
           matrix[ y             ; x             ]
        && matrix[ y + size.pred ; x             ]
        && matrix[ y             ; x + size.pred ]
        && matrix[ y + size.pred ; x + size.pred ]
    }

    my \h = matrix.elems;
    my \w = matrix.head.elems;

    my $count = 0;
    for 2 .. min h, w -> \s {
        for 0 .. h - s -> \y {
            for 0 .. w - s -> \x {
                $count++ if all-ones y, x, s;
            }
        }
    }
    $count
}

#############################################################################

use Test;

is count-squares([[1, 1], [1, 1]]), 1, 'Simple matrix';
is count-squares([[1, 1], [1, 0]]), 0, 'Simple matrix, incomplete';
is count-squares([[1, 1], [1, 0], [1, 1], [1, 1]]), 1, 'Simple (w != h) matrix';
is count-squares([[1, 1], [1, 1], [1, 1], [1, 1]]), 3, 'Simple (w != h) matrix, all complete';
is count-squares([[0, 1, 0, 1], [0, 0, 1, 0], [1, 1, 0, 1], [1, 0, 0, 1]]), 1, 'Example test 1';
is count-squares([[1, 1, 0, 1], [1, 1, 0, 0], [0, 1, 1, 1], [1, 0, 1, 1]]), 4, 'Example test 2';
is count-squares([[0, 1, 0, 1], [1, 0, 1, 0], [0, 1, 0, 0], [1, 0, 0, 1]]), 0, 'Example test 3';

done-testing;
