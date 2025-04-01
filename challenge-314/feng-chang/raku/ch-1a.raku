#!/bin/env raku

unit sub MAIN(*@strs);

my @lens = @strs».chars;
put ([eq] @strs.map({ $_|.substr(0,*-1) }))              ??
    (([==] @lens) ?? +@strs !! +@lens.grep(*>@lens.min)) !!
    -1;
