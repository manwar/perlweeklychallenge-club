#!/bin/env raku

sub largest-rectangle-histogram(Int:D @A) {
    print "[{@A}] -> ";
    0..@A.elems-1 X 0..@A.elems-1                           ==>
        grep { .[0] ≤ .[1] }                                ==>
        map { min(|@A[.[0] .. .[1]]) * (.[1] - .[0] + 1) }  ==>
        max()                                               ==>
        say();
}

largest-rectangle-histogram(my Int @ = 2, 1, 4, 5, 3, 7);
largest-rectangle-histogram(my Int @ = 3, 2, 3, 5, 7, 5);
