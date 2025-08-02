#!/usr/bin/env raku

sub jump ($from, +@ints) {
    $from «+« ( 1..@ints[$from] )
}

sub jump-game (+@ints) {
    (0,), { .unique.map: { |jump $_, @ints } } ... *
    andthen .head: @ints.elems
    andthen .first: -> @where {  @ints.end ∈ @where }, :k
}

multi MAIN (Bool :test($)!) {
    use Test;
    is jump( 2, (2,3,1,1,4) ), 3;
    is jump( 0, (2,3,1,1,4) ), (1,2);
    is jump( 1, (2,3,1,1,4) ), (2,3,4);
    is jump-game(2,3,1,1,4),2;
    is jump-game(2,3,0,4),2;
    is jump-game(2,0,0,4),Nil;
    is jump-game(1,1,1,1,1,1,0),6;
    is jump-game(0,0),Nil;
    done-testing;
}

multi MAIN (+@ints) {
    say jump-game( @ints ) // -1
}
