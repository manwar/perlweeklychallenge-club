#!/bin/env raku

unit sub MAIN(Str:D $input);

use MONKEY-SEE-NO-EVAL;
my @matrix;
EVAL "@matrix = $input";

put @matrix.map({ .min(:kv) }).first({ @matrix[*;.[0]].max == .[1] })[1] // -1;
