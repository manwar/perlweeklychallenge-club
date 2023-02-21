sub task2 (@matrix, UInt $r, UInt $c) {
    return @matrix.flat.elems == $r * $c
        ?? @matrix.flat.batch($c)
        !! 0;
}


my @tests =
    ( 1, 4, ( ( 1, 2    ) , ( 3, 4    ) ) ) => ( ( 1, 2, 3, 4, ),             ),
    ( 3, 2, ( ( 1, 2, 3 ) , ( 4, 5, 6 ) ) ) => ( ( 1, 2 ), ( 3, 4 ), ( 5, 6 ) ),
    ( 3, 2, ( ( 1, 2    ) ,             ) ) => 0                               ,
;
use Test;
plan +@tests;
for @tests -> ( :key($in), :value($expected) ) {
    my ( $r, $c, $matrix ) = $in.list;
    is-deeply task2( $matrix, $r, $c ), $expected;
}
