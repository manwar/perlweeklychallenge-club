#!/bin/env raku

unit sub MAIN(*@ints where +* > 3);

@ints = +«@ints;
my $diff = @ints.pop;
put +@ints.grep({ all($_ - $diff, $_ + $diff) (elem) @ints });
