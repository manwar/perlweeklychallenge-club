#!/usr/bin/env raku
use v6.*;

sub comb ($n,$k) {
    $n-$k ^.. $n Z/ 1 .. $k
    andthen [*] $_
}

enum HandRank (
    'Five-of-a-kind' => 1, |<
    Straight-flush
    Four-of-a-kind
    Full-house
    Flush
    Straight
    Three-of-a-kind
    Two-pair
    One-pair
    High-card
>);

proto hand-rank (HandRank() $?) { * }
multi hand-rank () { comb 52, 5 }
multi hand-rank(Five-of-a-kind) {0}
multi hand-rank (Straight-flush) {
    <🂡>..<🂮>
    andthen .rotor: 5 => -4
    andthen .elems*4
}
multi hand-rank(Four-of-a-kind) {(52-4)*52/4}
multi hand-rank(Full-house) {2*comb(52/4,2)*comb(4,3)*comb(4,2)}
multi hand-rank(Flush) {4*comb(52/4, 5) - hand-rank(Straight-flush)}
multi hand-rank(Straight) {hand-rank(2)*4⁴-hand-rank(Straight-flush)}
multi hand-rank(Three-of-a-kind) {52*comb((52/4-1),2)*4²}
multi hand-rank(Two-pair) {comb(4,2)²*comb(52/4,2)*(52-8)}
multi hand-rank(One-pair) {comb(4,2)*52/4*comb((52/4-1),3)*4³}
multi hand-rank(High-card) {comb(52/4,5)*4⁵ - hand-rank(Straight-flush) - hand-rank(Flush) - hand-rank(Straight)}
multi hand-rank(HandRank(Int) $_) { hand-rank $_ }
multi hand-rank($_) {0}

multi MAIN (Bool :test($)!) {
    use Test;
    is comb(5,2),10;
    is comb(5,0), 1;
    is comb(100,100), 1;
    is comb(20,7), comb(20,20-7);
    is comb(1000,501), comb(1000,499);
    is comb(1000,1), comb(1000,999);
    is hand-rank(),              2_598_960;
    is hand-rank(Straight-flush),       40;
    is hand-rank(Four-of-a-kind),      624;
    is hand-rank(Full-house),        3_744;
    is hand-rank(Flush),             5_108;
    is hand-rank(Straight),         10_200;
    is hand-rank(Three-of-a-kind),  54_912;
    is hand-rank(Two-pair),        123_552;
    is hand-rank(One-pair),      1_098_240;
    is hand-rank(High-card),     1_302_540;
    is (Five-of-a-kind..High-card).map( &hand-rank).sum, hand-rank();
    done-testing;
}

multi MAIN(Int:D $hr) {say hand-rank $hr}

multi MAIN (
    HandRank:D :hand-rank(:$hr),
) {
    say hand-rank $hr;
}
