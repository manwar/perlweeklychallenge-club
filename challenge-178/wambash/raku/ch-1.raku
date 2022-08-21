#!/usr/bin/env raku

multi to-quater-imaginary-base (Int $n) {
    \(div => -$n,rem => 0), { \(div => (.<div> div -4), rem => abs(.<div> mod -4 ) ) } ... *.<div> == 0
    andthen .skip
    andthen .map: *.<rem>
    andthen .join: "0"
    andthen .flip
}

multi  to-quater-imaginary-base (Int :$re, Int :$im) {
    to-quater-imaginary-base($re)+to-quater-imaginary-base(-2*$im)*0.1;
}

multi from-quater-imaginary-base (UInt $n) {
    $n.flip
    andthen .comb
    andthen $_ Z* (1, * * 2*i ... *)
    andthen .sum
    andthen .narrow
}

multi MAIN (Bool :test($)!) {
    use Test;
    is to-quater-imaginary-base(  4),  10300;
    is to-quater-imaginary-base( 35),  20003;
    is to-quater-imaginary-base(-13),1030003;
    is to-quater-imaginary-base( re => -3, im => -2),1131;
    is to-quater-imaginary-base( re => 35, im => 23), 121003.2;
    is from-quater-imaginary-base(  10300),  4;
    is from-quater-imaginary-base( 20003),  35;
    is from-quater-imaginary-base(1030003),-13;
    is from-quater-imaginary-base(  1131), -3-2*i;
    is from-quater-imaginary-base( 121003 ), 35+24*i;
    done-testing;
}

multi MAIN (Int $n, Bool :to(:t($))) {
    say to-quater-imaginary-base $n
}

multi MAIN (Int $n, Int :$im!, Bool :to(:t($))) {
    say to-quater-imaginary-base re => $n, :$im
}


multi MAIN ( Int $n, Bool :from(:f($))! ) {
    say from-quater-imaginary-base $n
}
