#!/usr/bin/env raku

sub challenge(Str $S, Str $T) returns Int {
    my $regex = $T.comb.join('.*');
    ($S ~~ m:exhaustive/<$regex>/).Int;
}

multi sub MAIN(Str $S, Str $T) {
    say challenge($S, $T);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ('littleit', 'lit', 5),
        ('london'  , 'lon', 3)
    );

    for @tests -> ($S, $T, $expected) {
        is(challenge($S, $T), $expected);
    }

    done-testing;
}

