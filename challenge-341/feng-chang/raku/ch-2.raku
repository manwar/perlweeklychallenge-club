#!/bin/env raku

unit sub MAIN(Str:D $w, Str:D $c where *.chars == 1);

with $w.index($c) + 1 -> $i {
    put $w.substr(0,$i).flip, $w.substr($i);
}
