#!/usr/bin/env raku

multi clock-angle ($h, $m) {
    $h*30+$m*(-11/2)
    andthen .abs
    andthen $_ min 360 - $_
}

multi MAIN ($s ) {
    say clock-angle |$s.split: ':';
}

multi MAIN (Bool :test($)!) {
    use Test;
    is clock-angle(3,10), 35;
    is clock-angle(4,0), 120;
    is clock-angle(3,49+1/11), 180;
    done-testing;
}
