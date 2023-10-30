#!/usr/bin/env raku

sub common-characters (+words) {
    words
    andthen .map: *.comb.Bag
    andthen [∩] $_
    andthen .kxxv
    andthen .sort
}

multi MAIN (Bool :test($)!) {
    use Test;
    is common-characters(<java javascript julia>), <a j>;
    is common-characters(<bella label roller>), <e l l>;
    is common-characters(<cool lock cook>), <c o>;
    done-testing;
}

multi MAIN (*@words) {
    put common-characters @words
}
