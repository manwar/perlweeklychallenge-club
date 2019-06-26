#!/bin/env perl6

sub MAIN(UInt $n) {
    my @eck = 0, 0;

    for 2..$n -> Int $i {
        @eck[$i] = 0;

        for $i - 2 ... 0 -> Int $j {
            if @eck[$j] == @eck[$i - 1] {
                @eck[$i] = $i - $j - 1;
                last;
            }
        }
    }

    say @eck;
}
