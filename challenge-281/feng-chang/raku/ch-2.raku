#!/bin/env raku

unit sub MAIN(Str:D $p1 where *.chars == 2, Str:D $p2 where *.chars == 2);

with |$p1.comb, |$p2.comb -> (\c1,\d1,\c2,\d2) {
    put dist(abs(c1.ord - c2.ord), abs(d1 - d2));
}

proto _dist(Int:D \x, Int:D \y --> UInt:D) {*}
multi _dist(\x where * < 0, $_) { Inf }
multi _dist($_, \y where * < 0) { Inf }
multi _dist(0, 0) { 0 }
multi _dist(0, 1) { 3 }
multi _dist(1, 1) { 2 }
multi _dist(0, 2) { 2 }
multi _dist(\x, \y where x > y) { _dist(y, x) }
multi _dist(\x, \y) { min(_dist(x - 1, y - 2), _dist(x - 2, y - 1)) + 1 }

sub dist(UInt:D \x, UInt:D \y --> UInt:D) {
    state %dists;
    my \K = "{x},{y}";
    %dists{K} = _dist(x, y) without %dists{K};

    %dists{K}
}
