#!/bin/env raku

unit sub MAIN(Str:D $s);

use MONKEY-SEE-NO-EVAL;

my @m = EVAL $s;
put @m.map(-> @a {
    with @m.grep({ $_[0] ≥ @a[1] }, :k) {
        .elems ?? .min({ @m[$_;0] }) !! -1
    }
});
