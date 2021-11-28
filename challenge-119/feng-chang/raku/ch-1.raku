#!/bin/env raku

sub MAIN(UInt:D $N where * ≤ 255) {
    put $N.fmt('%02x').comb.reverse.join.parse-base(16);
}
