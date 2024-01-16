#!/bin/env raku

unit sub MAIN(Str:D $s);

use MONKEY-SEE-NO-EVAL;
my @a;
EVAL '@a = ' ~ $s;

my @b;
for ^(+@a - 1) -> $i {
    for ^(+@a[0] - 1) -> $j {
        @b[$i;$j] = @a[$i;$j] + @a[$i;$j+1] + @a[$i+1;$j] + @a[$i+1;$j+1];
    }
}
put @b.raku;
