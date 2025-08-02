#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int && @ints.elems > 0);

say @ints.Bag.grep({ $_.key == $_.value })>>.key.sort.tail // -1;
