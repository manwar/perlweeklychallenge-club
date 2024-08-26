#!/bin/env raku

unit sub MAIN(*@ints);

with @ints.Bag.grep({ .key == .value })».value.max {
    when -Inf { put -1 }
    default   { .put }
}
