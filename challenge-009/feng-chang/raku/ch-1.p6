#!/bin/env perl6

for (101 ... *) -> $n {
    my int $n2 = $n * $n;
    last if $n2.comb.unique.elems >= 5;

    LAST { say "$n2 = $n * $n" }
}
