#!/bin/env raku

sub MAIN(UInt:D $N where * ≥ 10) {
    put $N.comb».Int.map(*²).reduce(&infix:<+>).&{ +(sqrt($_).Int² == $_) };
}
