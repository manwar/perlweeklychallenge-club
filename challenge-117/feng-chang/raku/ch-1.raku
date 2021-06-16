#!/bin/env raku

sub MAIN(Str:D $f where *.IO.f = 'input.txt') {
    my Set $nums = (1..15).Set;
    for $f.IO.lines -> $line {
        $line ~~ m/^ (\d+)/;
        $nums (-)= ($0.UInt).Set;
    }
    put 'the missing number: ', $nums.keys;
}
