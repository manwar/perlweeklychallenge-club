#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && all(@ints) ~~ Int);

say "({ @ints.map({ @ints.grep( * < $_ ).elems }).join(", ") })";
