#!/bin/env raku

unit sub MAIN(*@ints);

my $x = @ints.pop;
put (@ints.join + $x).comb;
