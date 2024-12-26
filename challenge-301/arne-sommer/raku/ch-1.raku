#! /usr/bin/env raku

subset PosInt of Int where * > 0;

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ PosInt);

say @ints.permutations.map( *.join ).max;
