#!/bin/env raku

unit sub MAIN(*@ints);

@ints = +«@ints;
put +@ints.combinations(3).grep({ .[0]!=.[1] && .[1]!=.[2] && .[2]!=.[0] });
