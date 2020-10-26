#! /usr/bin/raku

sub count-squares(\matrix) {
    sub all-ones(\x, \y, \size) {
           matrix[ x             ; y             ]
        && matrix[ x + size.pred ; y             ]
        && matrix[ x             ; y + size.pred ]
        && matrix[ x + size.pred ; y + size.pred ]
    }

    my \h = matrix.elems;
    my \w = matrix.head.elems;

    my $count = 0;
    for 2 .. max h, w -> \s {
        for 0 .. w - s -> \y {
            for 0 .. h - s -> \x {
                $count++ if all-ones x, y, s;
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
