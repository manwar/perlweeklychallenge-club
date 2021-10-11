#!/bin/env raku

put (1_023_000_000 .. ∞).grep(*.comb.sort.unique.elems == 10)[^10];
