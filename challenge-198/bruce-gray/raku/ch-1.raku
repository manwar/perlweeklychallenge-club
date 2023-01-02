sub task1 ( @list --> UInt ) {
    return @list.sort(+*)
                .rotor(2 => -1)
                .map({[R-] .list})
                .maxpairs
                .elems;
}


my @tests =
    ( (2,5,8,1) , 2 ),
    ( (3,)      , 0 ),
;
use Test;
plan +@tests;
for @tests -> ($in, $expected) {
    is task1($in), $expected;
}
