#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.pairs.map({ .value² if +@ints %% (.key + 1) }).sum;
