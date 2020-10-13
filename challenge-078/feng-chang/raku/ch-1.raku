#!/bin/env raku

sub leaders(@A) {
    gather {
        for 0 ..^ @A.elems -> $i {
            take @A[$i] if @A[$i] > all(@A[$i+1..*-1]);
        }
    }
}

say leaders(Array.new(9, 10, 7, 5, 6, 1));
say leaders(Array.new(3, 4, 5));
say leaders(Array.new());
