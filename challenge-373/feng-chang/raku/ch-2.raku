#!/bin/env raku

unit sub MAIN(Str:D $list, UInt:D $n);

my @list = $list.words;
with +@list div $n, +@list mod $n -> ($size, $rem) {
    when $size == 0 { put -1; }
    default {
        put (^$n).map(-> $i {
            "({@list.splice(0, $i < $rem ?? $size+1 !! $size).join(',') })"
        }).join(',');
    }
}
