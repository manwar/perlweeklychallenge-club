sub task2 ( Str $s --> Str ) {
    return $s.comb.rotor(2 => -1)».join.Bag.maxpairs».key.min;

    # Or, use the min-of-negative trick to remove `.maxpairs».key` :
    # return $s.comb.rotor(2 => -1)».join.Bag.min({ -.value, .key }).key;
}


my @tests =
    <bc abcdbca>,
    <ab cdeabeabfcdfabgcd>,
;
use Test; plan @tests;
for @tests -> ($expected, $in) {
    is task2($in), $expected, $in;
}
