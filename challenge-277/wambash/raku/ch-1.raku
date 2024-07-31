#!/usr/bin/env raku

sub count-common (+words) {
    words
    andthen .map: *.Bag
    andthen .map: *.nodemap: * ≤ 1
    andthen [∩] $_
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is count-common(<Perl is my friend>, <Perl and Raku are friend>), 2;
    is count-common(<Perl and Python are very similar>, <Python is top in guest languages>), 1;
    is count-common(<Perl is imperative Lisp is functional>, <Crystal is Similar to Ruby>), 0;
    done-testing;
}

multi MAIN (+words) {
    say count-common words».words
}
