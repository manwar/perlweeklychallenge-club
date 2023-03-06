sub task2 ( @ns where { .elems %% 2 }--> UInt ) {
    # return @ns.permutations.map({ .batch(2)».min.sum }).max; # Brute force
    return @ns.sort(+*).batch(2)».[0].sum;  # Maximize sum by minimizing the gaps inside each pairing.
}


constant @tests =
    ( (1,2,3,4), 4 ),
    ( (0,2,1,3), 2 ),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is task2($in), $expected;
}
