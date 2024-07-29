sub task2 ( Str $s --> Bool ) {

    my $vowel_count = $s.comb(/:i<[aeiou]>/).elems;

    return $vowel_count %% 2;
}


use Test; plan +constant @tests =
    ( False , 'perl' ),
    ( True  , 'book' ),
    ( True  , 'good morning' ),
;
for @tests -> ( $expected, $in ) {
    is task2($in), $expected, $in;
}
