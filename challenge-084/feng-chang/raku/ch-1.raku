#!/bin/env raku

constant \imin = -2_147_483_648;
constant \imax =  2_147_483_647;

sub MAIN(Int:D $n) {
    given $n {
        when (0)             { put 0 }
        when (0 < $n ≤ imax) { put $n.flip; }
        when (imin ≤ $n < 0) { put '-', (-$n).flip; }
        default              { put 0; }
    }
}
