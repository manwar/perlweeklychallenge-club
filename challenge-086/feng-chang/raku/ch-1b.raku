#!/bin/env raku

sub USAGE() {
print Q:c:to/END/; 
    Usage: {$*PROGRAM-NAME} <number A> <array N>
        e.g.:
            ./ch-1b.raku 7   10 8 12 15 5
            ./ch-1b.raku 6   1 5 2 9 7
            ./ch-1b.raku 15  10 30 20 50 40
    END
}

sub MAIN(Int:D $A, *@N) {
    put + [or] @N.combinations(2).map({ abs($_[0] - $_[1]) == abs($A)});
}
