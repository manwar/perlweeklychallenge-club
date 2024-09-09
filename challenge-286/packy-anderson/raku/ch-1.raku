#!/usr/bin/env raku
use v6;

my @words = $?FILE.IO.slurp.split(/\s+/, :skip-empty).Slip;

say @words[ (0 .. @words.elems).rand.Int ];
