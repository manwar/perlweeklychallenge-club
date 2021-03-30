#!/usr/bin/env raku

sub challenge(@N where all(@N) ~~ Int) returns Int {
    if @N.elems == 1 {
        0;
    } else {
        my @sorted = @N.sort;
        my @zipped = @sorted[0..*-1] Z @sorted[1..*];
        @zipped.map(-> ($a, $b) { abs($b - $a) }).max;
    }
}

multi sub MAIN(*@N where all(@N) ~~ Int) {
    say challenge(@N);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ((2, 9, 3, 5), 4),
        ((1, 3, 8, 2, 0), 5),
        ((5,), 0)
    );

    for @tests -> (@N, $expected) {
        is(challenge(@N), $expected);
    }

    done-testing;
}
