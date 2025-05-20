#!/bin/env raku

unit sub MAIN(*@ints);

my @ints_ = @ints.sort.unique;
put @ints.map({ @ints_.first($_, :k) + 1 });
