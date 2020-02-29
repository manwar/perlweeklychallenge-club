#!/usr/bin/env perl6

sub MAIN(Int $multiplier) {
    (1 .. ∞)
            .map(* * $multiplier)
            .grep(/^<[01]>+$/)
            .head(1)
            .say()
}
