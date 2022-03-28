#!/usr/bin/raku

sub MAIN(Int $n) {
    for 2 ..^ $n - 1 -> $B {
        my @digits = $n.base($B).comb;
        if @digits.all == @digits[0] {
            say 1;
            exit;
        }
    }

    say 0;
}