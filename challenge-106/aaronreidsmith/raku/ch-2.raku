#!/usr/bin/env raku

sub challenge(Numeric $N, Numeric $D) returns Str {
    my ($base, $repeating) = ($N / $D).base-repeating;
    $repeating = $repeating eq '' ?? $repeating !! "\($repeating\)";
    $base ~ $repeating;
}

multi sub MAIN(Numeric $N, Numeric $D) {
    say challenge($N, $D);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        (1, 3, '0.(3)'),
        (1, 2, '0.5'),
        (5, 66, '0.0(75)'),
        (1, 7, '0.(142857)'),
        (1.1, 8.5, '0.1(2941176470588235)') # Should handle arbitrary numerics, if you're into that
    );

    for @tests -> ($N, $D, $expected) {
        is(challenge($N, $D), $expected);
    }

    done-testing;
}
