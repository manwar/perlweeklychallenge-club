#!/bin/env raku

use MONKEY-SEE-NO-EVAL;

unit sub MAIN(Str:D $s);

my @M;
EVAL "@M = $s";
put +is-reduced-echelon-matrix(@M);

sub is-reduced-echelon-matrix(@M --> Bool:D) {
    my $solid-row = +@M;
    --$solid-row while @M[$solid-row - 1].all == 0;

    my $leading-col = -1;
    for ^$solid-row -> \row {
        with @M[row] {
            return False if .all == 0;

            my \col = .first(?*, :k);
            return False if .[col] != 1;

            return False if col ≤ $leading-col;
            $leading-col = col;
        }
        return False unless @M[^row;$leading-col].all == 0;
    }

    True
}
