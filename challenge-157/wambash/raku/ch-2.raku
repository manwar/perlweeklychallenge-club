#!/usr/bin/env raku

sub brazilian-number ($n) {
    1 ^..^ $n-1
    andthen .map: { $_ => $n.polymod: $_ xx * }\
    andthen .first: -> ( :key($), :value(@v) ) { [==] @v }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is brazilian-number(7),       2 => 1 xx 3;
    is brazilian-number(6),       Nil;
    is brazilian-number(8),       3 => 2 xx 2;
    is brazilian-number(('A' x 5).parse-base: 12), 12 => 10 xx 5;
    is brazilian-number(  87*152 + 87 ), 152 => 87 xx 2;
    done-testing;
}

multi MAIN ($n) {
    say brazilian-number $n
}
