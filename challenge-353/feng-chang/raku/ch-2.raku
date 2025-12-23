#!/bin/env raku

unit sub MAIN(Str:D $input);

use MONKEY-SEE-NO-EVAL;

my (@codes, @names, @status);
EVAL $input;

put (^+@codes).map({(
        @codes[$_]  ~~ /^ <[a..zA..Z0..9_]>+ $/                      &&
        @names[$_]  eq <electronics grocery pharmacy restaurant>.any &&
        @status[$_] eq 'true'
    ).Bool.lc
}).join(', ');
