#!/usr/bin/env raku

sub odd-one-out (+@words) {
    @words
    andthen .grep: { [le] .comb }\
    andthen $_ but  @words.elems - .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is odd-one-out(<abc xyz tsu>), <abc xyz>;
    is odd-one-out(<abc xyz tsu>).Int, 1;
    is odd-one-out(<rat cab dad>), ();
    is odd-one-out(<rat cab dad>).Int, 3;
    is odd-one-out(<x y z>), <x y z>;
    is odd-one-out(<x y z>).Int, 0;
    done-testing;
}

multi MAIN (*@words) {
     odd-one-out(@words)
     andthen put .Int => $_
}
