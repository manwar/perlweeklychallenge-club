#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int,
               UInt :$x,
	       UInt :$y where $x <= $y <= @ints.end,
               :v(:$verbose));

say ": ({ @ints[$x .. $y].join(", ") }).sum" if $verbose;

say @ints[$x .. $y].sum;
