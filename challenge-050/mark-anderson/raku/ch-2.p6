#!/usr/bin/env perl6

my @L = [2, 6, 1, 3];

for @L -> $n {
    if $n < @L.elems {
        if @L.grep(* > $n).elems == $n {
            say $n;
        }
    }
}
