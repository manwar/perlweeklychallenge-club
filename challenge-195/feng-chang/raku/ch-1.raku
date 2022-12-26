#!/bin/env raku

unit sub MAIN(UInt:D \n);

put (1..n).grep({ .comb.unique.elems == .chars }).elems;
