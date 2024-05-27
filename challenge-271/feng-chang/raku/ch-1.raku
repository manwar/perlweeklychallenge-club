#!/bin/env raku

unit sub MAIN(Str:D $s);

use MONKEY-SEE-NO-EVAL;

my @a = EVAL $s;
put @a.map(+*.grep(1)).max(:k).min + 1;
