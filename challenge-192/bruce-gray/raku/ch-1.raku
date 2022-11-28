# Faster, by about 10x
sub all_ones ( UInt $n --> UInt ) { ( 1 +< ($n.log2.floor + 1) ) - 1 }
sub fast1    ( UInt $n --> UInt ) { $n +^ all_ones($n) }

# Clearer:
sub task1    ( UInt $n --> UInt ) {
    return $n.base(2)
             .trans( <0 1> => <1 0> )
             .parse-base(2);
}


my @tests =
    ( 5, 2 ),
    ( 4, 3 ),
    ( 6, 1 ),
;
use Test;
plan +@tests + 1;
for @tests -> ( $in, $expected ) {
    is task1($in), $expected, "task1($in) == $expected";
}
{
    my Range $r  = 1 .. (2 ** 14);
    my Bool  $ok = not defined first { .&task1 != .&fast1 }, $r.list;
    ok $ok, "Two different approaches over {$r.raku}";
}
