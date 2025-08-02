#!/bin/env raku

unit sub MAIN(*@ints);

with @ints.sort.unique -> @a {
    put +@a > 2 ?? @a[*-3] !! @a[*-1];
}
