#!/bin/env raku

sub MAIN(UInt:D $N) {
    put (2..$N).grep(!*.comb.grep(1)).elems;
}
