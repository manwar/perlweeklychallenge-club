#!/bin/env raku

unit sub MAIN(*@ints where @ints».Int.sort eqv (1..+@ints).Seq);

with @ints.first(1, :k), @ints.first(+@ints, :k) -> (\A, \B) {
    put +@ints + A - B - 1 - (A > B);
}
