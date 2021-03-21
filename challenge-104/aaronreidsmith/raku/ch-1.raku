#!/usr/bin/env raku

use experimental :cached;

sub fusc(Int(Rat) $n) is cached returns Int {
    given $n {
        when 0      { 0 }
        when 1      { 1 }
        when * %% 2 { fusc($n / 2) }
        default     { fusc(($n - 1) / 2) + fusc(($n + 1) / 2) }
    }
}

multi sub MAIN(Int $terms = 50) {
    say (^$terms).map(&fusc);
}

multi sub MAIN(Bool :$test) {
    use Test;

    # Picked random terms in the sequence
    my @tests = (
        (7,  3),
        (28, 3),
        (50, 7)
    );

    for @tests -> ($n, $expected) {
        is(fusc($n), $expected);
    }

    done-testing;
}
