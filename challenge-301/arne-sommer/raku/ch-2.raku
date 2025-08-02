#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && all(@ints) ~~ Int);

say @ints.combinations(2).map({ ( @_[0] +^ @_[1] ).fmt('%b').comb.sum }).sum;

