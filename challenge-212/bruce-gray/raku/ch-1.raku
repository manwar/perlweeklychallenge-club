sub task1 ( Str $s, @ns --> Str ) {

    sub step ( Str $letter, UInt $distance --> Str ) {
        constant $a = 'a'.ord;

        return ( (( $letter.lc.ord - $a + $distance ) % 26 ) + $a ).chr;
    }

    return ($s.comb Z[&step] @ns).join.samecase($s);

    # Original one-liner:
    # return ($s.comb Z @ns).map({ ( (( .[0].lc.ord - $a + .[1]) % 26 ) + $a ).chr }).join.samecase($s);
}


my @tests =
    ( 'Perl', (2,22,19,9), 'Raku' ),
    ( 'Raku', (24,4,7,17), 'Perl' ),
;
use Test;
plan +@tests;
for @tests -> ( $in_str, @in_jumps, $expected ) {
    is task1( $in_str, @in_jumps ), $expected;
}
