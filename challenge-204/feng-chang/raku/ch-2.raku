#!/bin/env raku

unit sub MAIN();

my @N = $*IN.words;
my ($r, $c) = @N.splice(*-2);

put $r * $c == +@N ??
    (^$r).map({ "[ { @N[$c*$_ ..^ $c*($_+1)].join(' ') } ]" }).join("\n")  !!
    0;
