#!/usr/bin/env raku

sub consecutive-sequence-reducer ( @n, $b ) {
    with @n {
        when .[0][0] -1 == $b { ($b,|.head), |.skip }
        default               { ($b,)      , |$_    }
    }
}

sub longest-consecutive-sequence (+@n) {
    @n
    andthen .sort
    andthen .reverse
    andthen .cache
    andthen ((.head), ), |.skip
    andthen .reduce: &consecutive-sequence-reducer
    andthen .max: *.elems
    andthen .elems > 1 ?? $_ !! 0
}

multi MAIN(*@n) {
    say longest-consecutive-sequence @n
}

multi MAIN (Bool :$test!) {
    use Test;
    is-deeply consecutive-sequence-reducer(( (2,3), ), 1), ((1,2,3),   );
    is-deeply consecutive-sequence-reducer(( (2,3), ), 0), ((0,), (2,3));
    is longest-consecutive-sequence(100,  4, 50,  3,  2), (2,  3,  4);
    is longest-consecutive-sequence( 20, 30, 10, 40, 50),           0;
    is longest-consecutive-sequence( 20, 19,  9, 11, 10), (9, 10, 11);
    done-testing;
}
