#!/usr/bin/env raku

sub sum-of-squares ($n) {
    $n.comb
    andthen .map: *²
    andthen .sum
    andthen  $_ == .sqrt.Int**2
}

multi MAIN ( Int $n ) {
    say +so sum-of-squares($n)
}

multi MAIN (Bool :test($)) {
    use Test;
    is sum-of-squares(34),True;
    is sum-of-squares(50),True;
    is sum-of-squares(52),False;
    done-testing;
}
