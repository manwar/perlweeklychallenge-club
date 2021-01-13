#!/usr/bin/env raku

sub find-nums(@L, $X, $Y) {
        ([X] @L xx 2)
        .map(*.join(''))
        .grep({!/^0/ && $_ < $Y})
        .join(", ")
        .say;
}

find-nums(<0 1 2 5>, 2, 21);
