#!/usr/bin/env perl6
use v6;

sub nob(@a) {
    @a.grep({ $_ == @a.grep( * > $_ ) })
}

say nob(@*ARGS.map(*.Int));

# run as <script> <space-separated array entries>
