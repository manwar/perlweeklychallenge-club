#!/bin/env raku

unit sub MAIN(*@ints where +@ints %% 2);

put @ints.sort.map({ $^b, $^a });
