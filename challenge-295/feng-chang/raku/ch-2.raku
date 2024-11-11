#!/bin/env raku

unit sub MAIN(*@ints);

put $_ < Inf ?? $_ !! -1 with jump-game(@ints, 0);

sub jump-game(@ints where +@ints > 0, UInt:D $steps is copy --> Any:D) {
    return $steps if +@ints == 1;
    return Inf if @ints[0] == 0;
    return $steps + 1 if @ints[0] ≥ +@ints;

    (1..@ints[0]).map({ jump-game(@ints[$_..*-1], $steps + 1) }).min
}
