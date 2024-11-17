#!/usr/bin/env raku

sub jump ($from, +@ints) {
    $from «+« ( 1..@ints[$from] )
    andthen .Slip
}

sub jump-game (+@ints) {
    (0,), { .unique.map: { jump $_, @ints } } ... -> @where {  @ints.end ∈ @where }\
    andthen .skip
    andthen .head: @ints.elems
    andthen .elems
    andthen $_ ≤ @ints.end ?? $_ !! -1
}

multi MAIN (Bool :test($)!) {
    use Test;
    is jump( 2, (2,3,1,1,4) ), 3;
    is jump( 0, (2,3,1,1,4) ), (1,2);
    is jump( 1, (2,3,1,1,4) ), (2,3,4);
    is jump-game(2,3,1,1,4),2;
    is jump-game(2,3,0,4),2;
    is jump-game(2,0,0,4),-1;
    is jump-game(1,1,1,1,1,1,0),6;
    is jump-game(0,0),-1;
    done-testing;
}

multi MAIN (+@ints) {
    say jump-game @ints
}
