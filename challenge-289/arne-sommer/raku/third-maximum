#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int,
               :v(:$verbose));

my @uniquely-sorted = @ints.sort.reverse.squish;

say ": Uniquely sorted: @uniquely-sorted[]" if $verbose;

say @uniquely-sorted.elems >= 3 ?? @uniquely-sorted[2] !! @uniquely-sorted[0];



