#!/usr/bin/env raku

sub range-list-reducer (Capture $a, Int $b) {
     $a.tail.tail == $b.pred
        ?? \( |$a.head(*-1), (|$a.tail,$b,) )
        !! \( |$a, $b )
}

sub range-list (+@list) {
    @list
    andthen \(.head,), |.skip
    andthen .reduce: &range-list-reducer
    andthen .grep: Positional
    andthen .map: {.head .. .tail}
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply range-list-reducer( \(1,(3,4)), 5 ), \(1,(3,4, 5));
    is-deeply range-list-reducer( \(1,(3,4)), 6 ), \(1,(3,4),6 );
    is-deeply range-list(1,3,4,5,7), (3..5,);
    is-deeply range-list(1,2,3,6,7,9), (1..3,6..7);
    is-deeply range-list(0,1,2,4,5,6,8,9), (0..2, 4..6, 8..9);
    done-testing;
}

multi MAIN (*@list) {
    say range-list( @list».Int )
}
