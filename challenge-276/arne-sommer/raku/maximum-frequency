#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int && all(@ints) > 0 && @ints.elems > 0,
               :v(:$verbose));

my $bag = @ints.Bag;

my $max-freq = $bag.values.max;

say ": The maximum frequency is $max-freq" if $verbose;

say $bag.grep( *.value == $max-freq ) * $max-freq;
