#!/usr/bin/env raku

sub represent-integer ( $n, $d ) {
    1 .. $n
    andthen .grep: *.comb.any == $d
    andthen .sum
    andthen $_ == $n
}

multi MAIN ( $n, $d ) {
    say represent-integer $n, $d
}

multi MAIN ( :test($)! ) {
    use Test;
    is represent-integer( 25, 7 ), False;
    is represent-integer( 24, 7 ), True;
    done-testing;
}
