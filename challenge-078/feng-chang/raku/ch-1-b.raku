#!/bin/env raku

sub leaders(@A) {
    @A[(^@A.elems).grep: { @A[$_] > @A[$_+1 .. *-1].all }];
}

say leaders(Array.new(9, 10, 7, 5, 6, 1));
say leaders(Array.new(3, 4, 5));
say leaders(Array.new());
