#!/bin/env raku

unit sub MAIN(Str:D $s);

use MONKEY-SEE-NO-EVAL;

put (EVAL $s)[*;*].sort[2];
