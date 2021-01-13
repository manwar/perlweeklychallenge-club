#! /usr/bin/env raku

subset PositiveIntZero of Int where * >= 0;
subset PositiveInt of Int where * > 0;

unit sub MAIN (PositiveInt $X, PositiveInt $Y, *@L where @L.elems > 1 && all(@L) ~~ PositiveIntZero);

(@L xx $X).flat.combinations(1..$X)>>.join>>.Int.unique.sort.grep({ .chars == $X && $_ < $Y }).join(", ").say





