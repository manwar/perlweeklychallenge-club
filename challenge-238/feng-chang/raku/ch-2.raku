#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.sort({ steps($_), $_ });

sub steps(UInt:D $n --> UInt:D) {
    my $steps = 0;
    my $m = $n;

    while $m.chars > 1 {
        $m = [*] $m.comb;
        ++$steps;
    }

    $steps
}
