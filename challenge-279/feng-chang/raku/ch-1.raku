#!/bin/env raku

unit sub MAIN(Str:D $letters, Str:D $weights);

put ($letters.comb(/<[A..Za..z]>/) Z=> +«$weights.comb(/\d+/)).sort(*.value)».key.join;
