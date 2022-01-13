#!/bin/env raku

my method sqrt(UInt:D \N: --> UInt:D) {
    my UInt $m;
    my UInt $n = N;

    repeat {
        $m = $n;
        $n = ($m + N div $m) div 2;
    } while $n < $m;

    $m
}

sub MAIN(UInt:D \N where * > 0) {
    put N.&sqrt;
}
