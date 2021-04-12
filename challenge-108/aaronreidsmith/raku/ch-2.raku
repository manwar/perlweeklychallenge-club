#!/usr/bin/env raku

use experimental :cached;

sub challenge(Int $n where $n >= 0) is cached returns Int {
    given $n {
        when 0|1 { 1 }
        default {
            my $n-minus-one = $n - 1;
            gather for (0..$n-minus-one) -> $k {
                take (^$n-minus-one).combinations($k) * challenge($k);
            }.sum
        }
    }
}

multi sub MAIN(Int $n = 10) {
    say (^$n).map(&challenge);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        # From the challenge
        (0, 1),
        (1, 1),
        (2, 2),
        (3, 5),
        (4, 15),
        # Additional
        (7, 877),
        (8, 4140)
    );

    for @tests -> ($n, $expected) {
        is(challenge($n), $expected);
    }

    done-testing;
}
