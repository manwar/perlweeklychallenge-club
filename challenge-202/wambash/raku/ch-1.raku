#!/usr/bin/env raku

sub consecutive-odds-producer ( Capture (:$acc, :result($)), $element ) {
    $element %% 2
    ?? \( :acc(Empty), :result($acc) )
    !! \( :acc(|$acc,$element), :result(Empty) )
}

sub consecutive-odds (+@list) {
    \(acc => Empty, result => Empty), |@list, 0
    andthen .produce: &consecutive-odds-producer
    andthen .map: *<result>
    andthen .first: *.elems ≥ 3
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply consecutive-odds-producer( \(:acc(1,3),:result(1,1,3) ), 3 ), \( :acc(1,3,3), :result(Empty) );
    is-deeply consecutive-odds-producer( \(:acc(1,3),:result(Empty) ), 4 ), \( :acc(Empty), :result(1,3  ) );
    is consecutive-odds(1,5,3,6), (1,5,3);
    is consecutive-odds(1,2,3,4), Nil;
    is consecutive-odds(2,6,3,5), Nil;
    is consecutive-odds(2,3,5,7), (3,5,7);
    is consecutive-odds(1,5,4,5,1,3,2,2,2,3,1,2,1,3), (5,1,3);
    done-testing;
}

multi MAIN (+@list) {
    say +so consecutive-odds @list
}
