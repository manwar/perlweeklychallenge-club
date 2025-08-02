multi sub task1 ( @ns where @ns.all >= 0 --> UInt ) { 
    return abs( @ns.sum - @ns.join.comb.sum );
}

multi sub task1 ( @ns --> UInt ) { 
    die q:to/END/;
    Even though the task says `array of integers`,
        no examples used negative ints,
        so I am not allowing them this week.
        See challenge-261/athanasius/raku/ch-1.raku
        for code that allows negative ints.
    END
}

use Test; plan +constant @tests =
    (   36, (1,2,3,45) ),
    (    9, (1,12,3) ),
    (    0, (1,2,3,4) ),
    ( 1296, (236, 416, 336, 350) ),
;
for @tests -> ( $expected, @ns ) {
    is task1( @ns ), $expected;
}

