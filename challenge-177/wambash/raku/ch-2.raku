#!/usr/bin/env raku

constant PalidromicPrimeCyclops = (
    ^∞
    andthen .grep: { !.contains("0") }\
    andthen .map:  { $_ ~ 0 ~ .flip }\
    andthen .grep:   *.is-prime
);

sub palidromic-prime-cyclops (UInt $k) {
  PalidromicPrimeCyclops.head($k)
}

multi MAIN (Bool :test($)!) {
    use Test;
    is palidromic-prime-cyclops(20), (
        101, 16061, 31013, 35053, 38083, 73037, 74047, 91019, 94049,
        1120211, 1150511, 1160611, 1180811, 1190911, 1250521, 1280821,
        1360631, 1390931, 1490941, 1520251,
    );
    done-testing;
}

multi MAIN ($k=20) {
    put palidromic-prime-cyclops $k
}
