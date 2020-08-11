#!/usr/bin/env perl6
use v6;

sub MAIN(Str:D $input) {
    my @matches = $input.comb( / (.) $0* / );
    say @matches.join("\n");
}


