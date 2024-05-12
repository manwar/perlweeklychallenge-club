# Common code
sub adds_to_same { (@^a X+ $^addend).Bag eqv @^b.Bag }

sub task1_detailed_failure ( @x, @y --> Rat ) {
    die if @x.elems != @y.elems;

    my Rat $ret = (@y.sum - @x.sum) / @x.elems;

    unless adds_to_same(@x, $ret.narrow, @y) {
        warn "If a answer existed, it would be $ret, but $ret added to `@x`(@x[]) does not result in `@y`(@y[]), so no answer exists.";
        return Nil;
    }

    return $ret;
}
sub task1_Z_minus ( @x, @y --> Numeric ) {
    die if @x.elems != @y.elems;

    my @y-x = (@y.sort Z- @x.sort).squish;

    return +@y-x == 1 ?? @y-x[0] !! Nil;
}
# Credit to roger-bell-west for the .min idea.
sub task1_concise ( @x, @y --> Numeric ) {
    return adds_to_same(@x, $_, @y) ?? $_ !! Nil given @y.min - @x.min;
}


constant @tests =
    (   2, (  3,  7,  5 ) , (  9,  5,  7 ) ),
    (   3, (  1,  2,  1 ) , (  5,  4,  4 ) ),
    (   3, (  2,        ) , (  5,        ) ),
    ( Nil, (  0,  3,  7 ) , (  2,  6,  8 ) ),
    (   0, (  5,  7,  9 ) , (  9,  5,  7 ) ),
    (  -2, ( -3, -7, -5 ) , ( -9, -5, -7 ) ),
    (  -3, ( -1, -2, -1 ) , ( -5, -4, -4 ) ),
    (  -3, ( -2,        ) , ( -5,        ) ),
    (  -3, (  5,        ) , (  2,        ) ),
;
constant @subs =
    :&task1_detailed_failure,
    :&task1_Z_minus,
    :&task1_concise,
;
use Test; plan +@subs * +@tests;
for @subs -> ( :key($sub_name), :value(&task1) ) {
    for @tests -> ( $expected, @x, @y ) {
        is task1(@x, @y), $expected, "$sub_name : @x[] : @y[]";
    }
}
