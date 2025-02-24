#!/bin/env raku

unit sub MAIN(Str:D $array-str);

use MONKEY-SEE-NO-EVAL;

my @a = EVAL $array-str;
put ([(&)] @a).keys.sort.join(',');
