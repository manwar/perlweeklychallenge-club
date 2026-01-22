#!/bin/env raku

unit sub MAIN(UInt:D $n);

put (1..$n X/ 1..$n).sort.unique.map({ "{.numerator}/{.denominator}" }).join(', ');
