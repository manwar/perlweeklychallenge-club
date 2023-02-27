#!/usr/bin/env raku

sub third-highest (+@list) {
    @list
    andthen .sort
    andthen .reverse
    andthen .squish
    andthen .[2]//.[0]
}

multi MAIN (Bool :test($)!) {
    use Test;
    is third-highest(5,3,4),3;
    is third-highest(5,6),6;
    is third-highest(5,4,4,3),3;
    done-testing;
}

multi MAIN (+@list) {
    say third-highest @list
}
