#!/bin/env raku

unit sub MAIN(Str:D $s);

use MONKEY-SEE-NO-EVAL;
my @m = EVAL $s;

my (\rows, \cols) = +@m, +@m[0];
my $max-area = 0;
for (^rows X ^rows).grep({ .[0] ≤ .[1] }) X (^cols X ^cols).grep({ .[0] ≤ .[1] }) -> ((\r0, \r1), (\c0, \c1)) {
    next unless r1 - r0 == c1 - c0;
    if @m[r0..r1;c0..c1].all == 1 {
        $max-area max= $_ with (r1 - r0 + 1) * (c1 - c0 + 1);
    }
}
put $max-area;
