#!/usr/bin/env raku

sub MAIN(UInt $m, UInt $n where $m >= $n > 0) {
    say (1..$m).combinations: $n; 
}
