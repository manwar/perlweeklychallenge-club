#!/usr/bin/env perl6

use v6;

sub MAIN(Int $count = 3) {
    my @L = (1..50).pick($count);
    find-noble-number(@L);
}

sub find-noble-number(@L) {
    for @L -> $N {
        say "Found noble number [$N] in the list [" ~ @L.Str ~ "]."
            if ((grep { .Int > $N }, @L).elems == $N);
    }
}
