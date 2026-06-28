#!/bin/env raku

unit sub MAIN(UInt:D $base = 10, UInt:D $limit = 1000);

my @a = gather for ^$limit -> $n {
    with $n.base($base) -> $m {
        take $n if $m.comb.map({ .parse-base($base) ** $m.chars }).sum.base($base) eq $m;
    }
}
put @a.join(', ');
