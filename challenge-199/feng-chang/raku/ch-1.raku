#!/bin/env raku

unit sub MAIN(*@N);

put @N.unique.map(-> \j {
    @N.grep(j, :k).combinations(2).elems
}).sum;
