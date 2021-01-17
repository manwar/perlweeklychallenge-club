#!/usr/bin/env raku

sub challenge(Int $N) {
    ($N.Str.flip eq $N.Str).Int;
}

multi sub MAIN(Int $N) {
    say challenge($N);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        (1221, 1),
        (-101, 0),
        (90, 0)
    );

    for @tests -> ($N, $expected) {
        is(challenge($N), $expected);
    }

    done-testing;
}
