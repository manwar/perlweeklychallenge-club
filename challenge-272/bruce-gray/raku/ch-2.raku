# FYI: I originally wrote `$s.comb».ord ...` in both subs,
# before I remembered https://docs.raku.org/routine/ords

sub task2_rotor ( Str $s --> UInt ) {
    return $s.ords
             .rotor(2 => -1)
             .map({ abs .[0] - .[1] })
             .sum;

    # Could replace the map with either of:
    #   .map({ abs [-] .list })
    #   .flat.map(&[-])».abs
}

sub task2_Z_skip ( Str $s --> UInt ) {
    return ( .list Z- .skip )».abs.sum given $s.ords.cache;
}


constant @tests =
    < 13 hello >,
    < 30 perl  >,
    < 37 raku  >,
;
constant @subs =
    :&task2_rotor,
    :&task2_Z_skip,
;
use Test; plan +@tests * +@subs;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests -> ($expected, $in) {
        is task2($in), $expected, "$sub_name : $in";
    }
}
