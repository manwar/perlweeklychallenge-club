#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int && @ints.elems > 0,
               :v(:$verbose));

my $bag = @ints>>.Int.Bag;

say ": Bag { $bag.raku }" if $verbose;

say $bag.grep(*.value == 1)>>.key.sort.join(",");
