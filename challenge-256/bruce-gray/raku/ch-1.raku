sub task1 ( @words --> UInt ) {
    return +grep { .[0] eq .[1].flip },
            combinations(@words, 2);
}


use Test; plan +my @tests =
    ( 1, <ab de ed bc> ),
    ( 0, <aa ba cd ed> ),
    ( 2, <uv qp st vu mn pq> ),
;
for @tests -> ( $expected, @in ) {
    is task1(@in), $expected;
}
