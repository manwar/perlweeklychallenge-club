#!/usr/bin/env perl6
use v6;

sub ldr(@a) {
    @a.[@a.keys.grep({ @a.[$_] == @a.[$_..*].max })]
}

say ldr(@*ARGS.map(*.Int));
