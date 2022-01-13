#!/bin/env raku

sub combo(UInt:D $N, UInt:D $pat --> Array:D) {
    my @digits = $N.comb».UInt;
    my UInt $n = @digits.shift;
    my @splits;

    for @digits Z $pat.fmt('%0' ~ $N.chars-1 ~ 'b').comb».UInt -> ($d, $j) {
        if ?$j {
            @splits.push($n);
            $n = $d;
        } else {
            $n = $n*10 + $d;
        }
    }
    @splits.push($n);

    @splits
}

sub MAIN(UInt:D $N) {
    put +((1 .. 2**($N.chars-1)-1).grep({ combo($N, $_).sum == sqrt($N) }).elems > 0);
}
