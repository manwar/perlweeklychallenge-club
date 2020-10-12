#!/bin/env raku

sub MAIN(UInt:D $M, UInt:D $N) {
    (1..min($M,$N)).grep({ ($M & $N) %% $_ }).say;
}
