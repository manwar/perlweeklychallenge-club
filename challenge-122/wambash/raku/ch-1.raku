#!/usr/bin/env raku

sub average-of-stream (+@n) {
    [\+] @n
    andthen $_ Z/ 1 .. *
}


multi MAIN (*@n) {
    say average-of-stream @n
}

multi MAIN (Bool :test($)!) {
    use Test;
    is average-of-stream(10,20 ... *).head(10), (10, 15, 20, 25, 30, 35, 40, 45, 50, 55);
    is average-of-stream(1,1, * + *  ... *).head(5),(1/1,2/2,4/3,7/4,12/5);
    done-testing;
}
