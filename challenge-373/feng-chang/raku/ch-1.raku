#!/bin/env raku

unit sub MAIN(Str:D $arr1, Str:D $arr2);

use MONKEY-SEE-NO-EVAL;

my @arr1 = EVAL $arr1;
my @arr2 = EVAL $arr2;
put @arr1.join eq @arr2.join;
