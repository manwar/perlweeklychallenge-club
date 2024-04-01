sub task1 ( @ns --> UInt ) {
    my ( $negatives, $zeros, $positives ) = @ns».sign.Bag{-1, 0, 1};

    if $zeros {
        warn "One or more `0` was found in the input, and the task was not clear on how they were to be treated.";
    }

    return $negatives max $positives;
}


use Test; plan +constant @tests =
    ( 4, ( -3,  1,  2, -1, 3, -2, 4 ) ),
    ( 3, ( -1, -2, -3,  1           ) ),
    ( 2, (  1,  2                   ) ),
;
for @tests -> ( $expected, @in ) {
    is task1( @in ), $expected;
}
