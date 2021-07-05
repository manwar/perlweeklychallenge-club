#!/usr/bin/env raku

sub MAIN(UInt:D $n where * > 0) {
    my @s = grep { ! / 0 | 11 / }, map { .base: 4 }, 1 .. ∞;
    say @s[$n - 1];
}
