#!/bin/env raku

my method is-ugly(Int:D $n: --> Bool:D) {
    my UInt $m = $n;

    $m div= 2 while $m %% 2;
    $m div= 3 while $m %% 3;
    $m div= 5 while $m %% 5;

    so $m == 1
}

sub MAIN(UInt:D $n where * > 0) {
    my @uglies = (1..∞).grep(*.&is-ugly);
    put @uglies[$n-1];
}
