#! /usr/bin/env raku

unit sub MAIN (Int $k,
               *@ints where @ints.elems > 0 && all(@ints) ~~ Int,
               :v(:$verbose));

say ": Sorted: { @ints.sort.join(",") }" if $verbose;

say '(', (@ints.sort.grep: $k, :k).join(", "), ')';
