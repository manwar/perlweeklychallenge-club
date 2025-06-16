#!/usr/bin/env raku

sub final-price (+prices) {
    |prices, 0
    andthen $_, *.skip ...^ *.elems == 1
    andthen .map: -> @ ($h, *@t) {
        $h - @t.first: { $_ ≤ $h }
    }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is final-price(8, 4, 6, 2, 3), (4,2,4,2,3);
    is final-price(1..5), 1..5;
    is final-price(7,1,1,5), (6,0,1,5);
    done-testing;
}

multi MAIN (+prices) {
    put final-price prices;
}
