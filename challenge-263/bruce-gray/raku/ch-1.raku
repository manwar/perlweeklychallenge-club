sub task1 ( UInt $k, @ns ) {
    return @ns.sort.grep: :k, $k;
}


use Test; plan +constant @tests =
    ( 2, (1, 5, 3, 2, 4, 2),    (1, 2) ),
    ( 6, (1, 2, 4, 3, 5   ),    ()     ),
    ( 4, (5, 3, 2, 4, 2, 1),    (4,)   ),
;
for @tests -> ( $k, @ns, @expected ) {
    is-deeply task1($k, @ns), @expected;
}
