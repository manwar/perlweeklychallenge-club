#!/usr/bin/perl6

(gather {
    for (100 .. Inf) -> $number {
        my @digits = $number.comb;
        if $number %% (@digits[0], @digits[*-1]).join(q{}) {
            take $number;
        }
    }
})[0 .. 19].join(', ').say;