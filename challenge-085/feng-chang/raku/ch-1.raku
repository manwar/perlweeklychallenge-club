#!/bin/env raku

sub MAIN(*@R where *.elems ≥ 3) {
    say +(@R.combinations(3)».sum.grep({ 1 < $_ < 2 }).elems > 0);
}
