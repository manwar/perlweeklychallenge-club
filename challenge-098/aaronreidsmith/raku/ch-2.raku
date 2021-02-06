#!/usr/bin/env raku

sub challenge(@N, Int $N) returns Int {
    my @new = $N ∉ @N ?? (|@N, $N).sort !! @N;
    @new.first($N, :k);
}

multi sub MAIN(Int $N, *@N where all(@N) ~~ Int) {
    say challenge(@N, $N)
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ((1, 2, 3, 4), 3, 2),
        ((1, 3, 5, 7), 6, 3),
        ((12, 14, 16, 18), 10, 0),
        ((11, 13, 15, 17), 19, 4)
    );

    for @tests -> (@N, $N, $expected) {
        is(challenge(@N, $N), $expected);
    }

    done-testing;
}
