#!/usr/bin/env raku

sub alien-dictionary (+words,:@alien) {
    my %alphabet = @alien.antipairs;
    words.sort: { %alphabet{ .comb } }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is alien-dictionary(
        <perl python raku>,
        :alien<h l a b y d e f g i r k m n o p q j s t u v w x c z>
    ), <raku python perl>;
    is alien-dictionary(
        <the weekly challenge>,
        :alien<c o r l d a b t e f g h i j k m n p q s w u v x y z>
    ), <challenge the weekly>;
    done-testing;
}

multi MAIN (+words,:$alien) {
    put alien-dictionary words,:alien($alien.comb)
}
