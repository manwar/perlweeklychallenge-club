#!/usr/bin/env raku

sub total-zero ($x,$y) {
   ($x,0), ($y,0), -> $x, $y { $x[0].polymod: $y[0] } ... *.[0] == 0
   andthen .map: *.[1]
   andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is total-zero(5,4),5;
    is total-zero(4,6),3;
    is total-zero(2,5),4;
    is total-zero(3,1),3;
    is total-zero(7,4),5;
    is total-zero(2**4,2**128),2**124;
    done-testing;
}

multi MAIN ($x,$y) {
    say total-zero $x,$y
}
