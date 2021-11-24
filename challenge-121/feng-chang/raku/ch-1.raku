#!/bin/env raku

sub MAIN(UInt:D $m where 0 ≤ * ≤ 255, UInt:D $n where 1 ≤ * ≤ 8) {
    put $m +^ (1 +< ($n - 1));
}
