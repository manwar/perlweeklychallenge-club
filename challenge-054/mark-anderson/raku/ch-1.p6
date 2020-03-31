#!/usr/bin/env raku 

sub MAIN(UInt $length, UInt $which where $length > 0 < $which) {
    say (1..$length).permutations[$which-1];
}
