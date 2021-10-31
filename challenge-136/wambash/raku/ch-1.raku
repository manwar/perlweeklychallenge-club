#!/usr/bin/env raku

sub two-friendly( $m,$n ) {
    $m gcd $n
    andthen .polymod: 2 xx *
    andthen .one.so
}

multi MAIN (Bool :test($)!) {
    use Test;
    is two-friendly( 8, 24), True;
    is two-friendly(26, 39), False;
    is two-friendly( 4, 10), True;
    done-testing;
}

multi MAIN ($m, $n) {
    say  +two-friendly $m, $n;
}
