#!/usr/bin/env raku

use experimental :cached;

proto score(UInt:D --> Seq) is cached {*}

multi score(0) { [], }

multi score($n) {
    gather for 1..3 -> $i {
        with try score($n - $i) -> @s {
            for @s {
                take [$i, |@_];
            }
        }
    }
}

sub MAIN(UInt $n) {
    .join(' ').say for score $n;
}
