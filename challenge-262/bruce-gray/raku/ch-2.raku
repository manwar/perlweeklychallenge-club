sub task2 ( UInt $k, @ns --> UInt ) {
    # Concise, but always O(N²) :
    #   return +grep { ([*] .list) %% $k and ([==] @ns[.list]) }, combinations(+@ns, 2);

    sub wanted ( ($i, $j) --> Bool ) { ($i × $j) %% $k }

    sub combin_count (@indexes) { @indexes.combinations(2).grep(&wanted).elems }

    return @ns.pairs.classify( *.value, :as{.key} ).map({ combin_count(.value) }).sum;
}


constant @n1_1000 = 1 .. 1000;                  # Best case; no .combinations() at all when no elements are equal.
constant @n10_100 = |(41..50) xx 100;
constant @n42_43  = |(42 xx 500), |(43 xx 500);
constant @n42     =   42 xx 1000;               # Worst case; O(N²) when all elements are identical
use Test; plan +constant @tests =
    ( 4, 2, (3,1,2,2,2,1,3) ),
    ( 0, 1, (1,2,3) ),

    (          0, 2, @n1_1000 ),
    (      24750, 2, @n10_100 ),
    (     187250, 2, @n42_43  ),
    (     374750, 2, @n42     ),
    ( 1000*999/2, 1, @n42     ),
;
for @tests -> ( $expected, $k, @in ) {
    is task2( $k, @in ), $expected;
}
