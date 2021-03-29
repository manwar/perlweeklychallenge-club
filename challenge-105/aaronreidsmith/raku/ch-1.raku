#!/usr/bin/env raku

sub challenge(Numeric $N, Numeric $k) returns Str {
    my $root = $k ** (1 / $N);
    $root.round(.01).Str;
}

multi sub MAIN(Num $N, Num $k) {
    say challenge($N, $k);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        (5, 248832, '12'),
        (5, 34, '2.02'),
        (5.5, 34.6, '1.9') # Should accept any Numeric
    );

    for @tests -> ($N, $k, $expected) {
        is(challenge($N, $k), $expected);
    }

    done-testing;
}
