#!/usr/bin/env raku 

sub MAIN(UInt $length, UInt $which) {
    say ((1..$length).permutations)[$which-1];
}
