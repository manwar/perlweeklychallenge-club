sub task2 ( @ns --> UInt ) {
    # Most concise and clear
    return +@ns.sort(-*).pairs.grep: { .value > .key };

    # Faster, but less clear
    # return @ns.sort(-*).pairs.first({ .value <= .key }).?key
    #     // @ns.elems;
}


constant @tests =
    ( ( 10, 8, 5, 4, 3 ), 4 ),
    ( ( 25, 8, 5, 3, 3 ), 3 ),
    ( (  2, 2, 2, 2, 2 ), 2 ),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is task2($in), $expected;
}
