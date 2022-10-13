#!/bin/env raku

unit sub MAIN(UInt:D \n);

put +?(2..n-2).grep({ n.base($_).comb.unique.elems == 1 });
