#!/bin/env raku

unit sub MAIN(Str:D $s);

use MONKEY-SEE-NO-EVAL;
my @matrix;
EVAL "@matrix = $s";

put @matrix.pairs.sort({ .value.sum, +.key })».key.join(', ');
