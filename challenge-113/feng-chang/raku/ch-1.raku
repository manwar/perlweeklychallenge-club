#!/bin/env raku

subset Digit of UInt where * ≤ 9;

sub MAIN(UInt:D $N = 25, Digit:D $D = 7) {
    put do given $N {
        when $N ~~ /$D/                                      { 1 }
        when $N == (1..^$N).grep(/$D/).combinations».sum.any { 1 }
        default                                              { 0 }
    }
}
