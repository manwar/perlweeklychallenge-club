#!/bin/env raku

sub USAGE() {
print Q:c:to/END/; 
    Usage: {$*PROGRAM-NAME} <number A> <array N>
        e.g.:
            ./ch-1.raku 7   10 8 12 15 5
            ./ch-1.raku 6   1 5 2 9 7
            ./ch-1.raku 15  10 30 20 50 40
    END
}

sub MAIN(Int:D $A, *@N) {
    put any(@N.combinations(2)).grep({ abs($^a - $^b) == abs($A) }).elems > 0 ?? 1 !! 0;
}
