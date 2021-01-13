#! /usr/bin/raku

multi spiral-matrix(@matrix where *.head.elems == 0, @acc) {
    @acc
}

multi spiral-matrix(@matrix, @acc = ()) {
    spiral-matrix rotator(@matrix[1 .. *]), (|@acc, |@matrix.head)
}

sub rotator(@matrix) {
    (^@matrix.head.elems).reverse.map: { @matrix>>[$^i] }
}

use Test;

is-deeply spiral-matrix((
( 1 ),
)),
( 1, ),
'One number';

is-deeply spiral-matrix((
( 1, 2, 3 ),
)),
( 1, 2, 3 ),
'One row';

is-deeply spiral-matrix((
( 1 ),
( 2 ),
( 3 ),
)),
( 1, 2, 3 ),
'One column';

is-deeply spiral-matrix((
( 1, 2, 3 ),
( 1, 2, 3 ),
)),
( 1, 2, 3, 3, 2, 1 ),
'Two rows';

is-deeply spiral-matrix((
( 1, 7 ),
( 2, 8 ),
( 3, 9 ),
)),
( 1, 7, 8, 9, 3, 2 ),
'Two columns';

is-deeply spiral-matrix((
( 1, 2, 3 ),
( 1, 2, 3 ),
( 1, 2, 3 ),
)),
( 1, 2, 3, 3, 3, 2, 1, 1, 2 ),
'Three rows';

is-deeply spiral-matrix((
( 1, 7, 4 ),
( 2, 8, 5 ),
( 3, 9, 6 ),
)),
( 1, 7, 4, 5, 6, 9, 3, 2, 8 ),
'Three columns';

is-deeply spiral-matrix((
( 1, 2, 3, 0 ),
( 4, 5, 6, 0 ),
( 4, 9, 1, 0 ),
( 7, 8, 9, 1 ),
)),
( 1, 2, 3, 0, 0, 0, 1, 9, 8, 7, 4, 4, 5, 6, 1, 9 ),
'4x4 matrix';

is-deeply spiral-matrix((
( 1, 2, 3 ),
( 4, 5, 6 ),
( 7, 8, 9 ),
)),
( 1, 2, 3, 6, 9, 8, 7, 4, 5 ),
'Example 1';

is-deeply spiral-matrix((
(  1,  2,  3,  4 ),
(  5,  6,  7,  8 ),
(  9, 10, 11, 12 ),
( 13, 14, 15, 16 ),
)),
( 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ),
'Example 2';

done-testing;
