#! /usr/bin/env raku

unit sub MAIN (Int :$x,
               *@ints where @ints.elems > 0
                  && all(@ints) ~~ /^<[0..9]>$/);

say "({ (@ints.join + $x).comb.join(", ") })";

