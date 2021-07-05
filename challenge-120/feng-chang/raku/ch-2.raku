#!/bin/env raku

sub MAIN(Str:D $T) {
    $T ~~ m/^ (\d\d) ':' (\d\d) $/;
    put abs(($0 % 12) * 30 - ($1 % 60) * 5.5);
}
