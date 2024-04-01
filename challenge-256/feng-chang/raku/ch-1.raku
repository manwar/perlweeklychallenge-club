#!/bin/env raku

unit sub MAIN(*@strs);

my %s is Set = @strs.grep({ $_ ne .flip });
put +%s.keys.grep({ %s{.flip} }) / 2;
