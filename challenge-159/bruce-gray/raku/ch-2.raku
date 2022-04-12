use Prime::Factor;

sub μ ( UInt $n ) {
    my ( $prime_count, $not_square_free ) = ( +.elems, ?.repeated )
        given prime-factors($n);

    return $not_square_free ?? 0 !! ( (-1) ** $prime_count );
}


my @tests =
     5 => -1,
    10 =>  1,
    20 =>  0,
;
use Test;
plan 1+@tests;
for @tests -> ( :key($in), :value($expected) ) {
    is μ($in), $expected, "μ($in)";
}
constant @A008683 = 1, -1, -1, 0, -1, 1, -1, 0, 0, 1, -1, 0, -1, 1, 1, 0, -1, 0, -1, 0, 1, 1, -1, 0, 0, 1, 0, 0, -1, -1, -1, 0, 1, 1, 1, 0, -1, 1, 1, 0, -1, -1, -1, 0, 0, 1, -1, 0, 0, 0, 1, 0, -1, 0, 1, 0, 1, 1, -1, 0, -1, 1, 0, 0, 1, -1, -1, 0, 1, -1, -1, 0, -1, 1, 0, 0, 1, -1;
is-deeply (1..78)».&μ , @A008683, "μ matches http://oeis.org/A008683 for 1..78";
