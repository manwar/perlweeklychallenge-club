#!/bin/env raku

unit sub MAIN(*@ints);

my \k = @ints.pop;
put @ints.sort.grep(k, :k).gist;
