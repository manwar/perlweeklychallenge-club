#!/usr/bin/env raku
use v6;

# run <script> <time>

sub angl($h,$m) {
    my $rawDiff = abs(($h % 12)*30 + $m/2 - $m * 6);
    return ($rawDiff <= 180) ?? ($rawDiff) !! (360-$rawDiff);
}

say angl(|@*ARGS[0].split(":").map(*.Int))
