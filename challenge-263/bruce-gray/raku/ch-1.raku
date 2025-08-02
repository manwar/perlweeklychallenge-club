sub task1 ( UInt $k, @ns ) {
    return @ns.sort.grep: :k, $k;
}


# Not my own invention, but too good for me to keep my hands off it.
# Benchy says it is 3.47x faster for the 2 million test case.
# See Peter Campbell Smith's analysis and algorithm at:
#       http://ccgi.campbellsmiths.force9.co.uk/challenge/263/1
sub task1_single_pass_without_sorting ( UInt $k, @ns ) {
    return flat .{Less} + ^.{Same} given ( @ns »<=>» $k ).Bag;
}


use Test; plan 2 * +constant @tests =
    ( 2, (1, 5, 3, 2, 4, 2),    (1, 2) ),
    ( 6, (1, 2, 4, 3, 5   ),    ()     ),
    ( 4, (5, 3, 2, 4, 2, 1),    (4,)   ),

    ( 42, (flat 1..1_000_000, 1..1_000_000).pick(*), (82,83,) ),
;
for @tests -> ( $k, @ns, @expected ) {
    is-deeply task1_single_pass_without_sorting($k, @ns), @expected;
    is-deeply task1($k, @ns), @expected;
}
