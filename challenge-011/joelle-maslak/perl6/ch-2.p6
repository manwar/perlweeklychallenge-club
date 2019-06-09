#!/usr/bin/env perl6
use v6;

sub MAIN(UInt:D $size where * ≥ 1) {
    for ^$size -> $row {
        my @row = (^$size).map: { 0 };
        @row[$row] = 1;
        say @row.join(" ");
    }
}

