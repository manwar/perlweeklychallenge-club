#!/bin/env raku

unit sub MAIN(Str:D $s);

use MONKEY-SEE-NO-EVAL;

my @a = EVAL $s;
my (\rows, \cols) = +@a, +@a[0];
put +(^rows X ^cols).grep(-> (\b,\c) {
     @a[b;c]          == 1        &&
     +@a[b].grep(0)   == cols - 1 &&
     +@a[*;c].grep(0) == rows - 1
});
