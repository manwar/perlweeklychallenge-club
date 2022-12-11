sub is_time_valid ( Str $s --> Bool ) {
    constant $valid_times = ( ^24 X ^60 ).map( *.fmt('%02d', ':') ).Set;
    return $s ∈ $valid_times;
}
sub task1 ( Str $s --> UInt ) {
    return (9…0).first: { $s.subst( '?', $_ ).&is_time_valid };
}
# See ch-1_compare.raku for alternate solutions


constant @tests =
    ( '?5:00', 1 ),
    ( '?3:00', 2 ),
    ( '1?:00', 9 ),
    ( '2?:00', 3 ),
    ( '12:?5', 5 ),
    ( '12:5?', 9 ),
;
use Test;
plan +@tests;
for @tests -> ($in, $expected) {
    is task1($in), $expected, "task1($in) == $expected";
}
