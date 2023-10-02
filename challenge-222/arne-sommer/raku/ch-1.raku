#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && all(@ints) ~~ Int && all(@ints) > 0);

say (@ints Z @ints.sort).grep( { $_[0] eq $_[1] }).elems;

