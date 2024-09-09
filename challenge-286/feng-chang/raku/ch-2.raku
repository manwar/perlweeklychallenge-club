#!/bin/env raku

unit sub MAIN(*@ints);

while +@ints > 1 {
    my @ints_ = gather for @ints -> $a, $b {
        take $++ %% 2 ?? min($a,$b) !! max($a,$b);
    }
    @ints = @ints_;
}

put @ints[0];
