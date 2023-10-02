#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ UInt);

say @ints.grep( * > 0).unique.elems;
