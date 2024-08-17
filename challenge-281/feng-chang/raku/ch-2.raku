#!/bin/env raku

multi MAIN(Str:D $p1 where *.chars == 2, Str:D $p2 where *.chars == 2) {
    with |$p1.comb, |$p2.comb -> (\c1,\d1,\c2,\d2) {
        put dist(abs(c1.ord - c2.ord), abs(d1 - d2));
    }
}

multi MAIN('test') {
    use Test;

    is dist(0, 0), 0, '0,0 => 0';
    is dist(0, 1), 3, '0,1 => 3';
    is dist(1, 0), 3, '1,0 => 3';
    is dist(0, 2), 2, '0,2 => 2';
    is dist(1, 2), 1, '1,2 => 1';
    is dist(2, 2), 4, '2,2 => 4';
    is dist(2, 0), 2, '2,0 => 2';
    is dist(2, 1), 1, '2,1 => 1';
    is dist(0, 3), 3, '0,3 => 3';
    is dist(1, 3), 2, '1,3 => 2';
    is dist(2, 3), 3, '2,3 => 3';
    is dist(3, 3), 2, '3,3 => 2';
    is dist(3, 0), 3, '3,0 => 3';
    is dist(3, 1), 2, '3,1 => 2';
    is dist(3, 2), 3, '3,2 => 3';
    is dist(0, 4), 2, '0,4 => 2';
    is dist(1, 4), 3, '1,4 => 3';
    is dist(2, 4), 2, '2,4 => 2';
    is dist(3, 4), 3, '3,4 => 3';
    is dist(4, 4), 4, '4,4 => 4';
    is dist(0, 5), 3, '0,5 => 3';
    is dist(0, 6), 4, '0,6 => 4';
    is dist(0, 7), 5, '0,7 => 5';
    is dist(0, 8), 4, '0,8 => 4';

    done-testing;
}

proto _dist(Int:D, Int:D --> UInt:D) {*}
multi _dist(\x where * < 0, $_) { Inf }
multi _dist($_, \y where * < 0) { Inf }
multi _dist(0, 0) { 0 }
multi _dist(0, 1) { 3 }
multi _dist(1, 1) { 2 }
multi _dist(0, 2) { 2 }
multi _dist(0, 3) { 3 }
multi _dist(1, 3) { 2 }
multi _dist(0, \y) { min(_dist(0, y - 2) + 2, _dist(0, y - 4) + 2, _dist(0, y - 5) + 3) }
multi _dist(\x, \y where x > y) { _dist(y, x) }
multi _dist(\x, \y) { min(_dist(x - 1, y - 2), _dist(x - 2, y - 1)) + 1 }

sub dist(UInt:D \x, UInt:D \y --> UInt:D) {
    state %dists;
    my \K = "{x},{y}";
    %dists{K} = _dist(x, y) without %dists{K};

    %dists{K}
}
