#!/bin/env raku

unit sub MAIN(Str:D $ops);

put .comb('++') - .comb('--') with $ops;
