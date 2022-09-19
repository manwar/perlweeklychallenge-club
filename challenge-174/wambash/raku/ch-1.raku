#!/usr/bin/env raku

sub is-disarium-number ($n) {
    $n == [+] $n.comb Z** 1 .. *
}

multi MAIN (Bool :test($)!) {
    use Test;
    is is-disarium-number($_),True, "$_ is disarium" for 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135, 175, 518, 598, 1306, 1676, 2427, 2646798, 12157692622039623539;
    is is-disarium-number($_),False, "$_ is not disarium" for 10, 134, 577;
    done-testing;
}

multi MAIN (UInt $k=19) {
    ^∞
    andthen .hyper
    andthen .grep: &is-disarium-number
    andthen .head: $k
    andthen .Supply.tap: *.put
}
