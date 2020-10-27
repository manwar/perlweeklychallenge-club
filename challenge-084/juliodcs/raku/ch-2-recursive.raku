#! /usr/bin/raku

sub count-squares(\matrix where matrix.elems > 1 && matrix.head.elems > 1) {
    my \height = matrix.elems;
    my \width = matrix.head.elems;
    my \max-square-size = min height, width;

    sub all-ones(\y, \x, \size) {
           matrix[ y             ; x             ]
        && matrix[ y + size.pred ; x             ]
        && matrix[ y             ; x + size.pred ]
        && matrix[ y + size.pred ; x + size.pred ]
    }

    multi count-squares(\size where * > max-square-size, \y, \x, \count) {
        count
    }

    multi count-squares(\size, \y where * > height - size, \x, \count) {
        count-squares size.succ, 0, 0, count
    }

    multi count-squares(\size, \y, \x where * > width - size, \count) {
        count-squares size, y.succ, 0, count
    }

    multi count-squares(\size, \y, \x, \count) {
        count-squares size, y, x.succ, count + all-ones y, x, size
    }

    count-squares 2, 0, 0, 0
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
