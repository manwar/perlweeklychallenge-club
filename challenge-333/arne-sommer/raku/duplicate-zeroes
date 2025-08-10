#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int);

say @ints.map({ $_ ?? $_ !! (0,0) })[*;*][0 .. @ints.end];
