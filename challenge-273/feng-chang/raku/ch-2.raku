#!/bin/env raku

unit sub MAIN(Str:D $s);

with $s.index('b') // -1 {
    put ($_ ≥ 0) && ($_ > ($s.rindex('a') // -1));
}
