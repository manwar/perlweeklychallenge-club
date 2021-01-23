#!/usr/bin/env raku

use Text::Levenshtein; # imports `distance`

sub challenge(Str $S1, Str $S2) returns Int {
    distance($S1.lc, $S2.lc).head;
}

multi sub MAIN(Str $S1, Str $S2) {
    say challenge($S1, $S2);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ('kitten', 'sitting', 3),
        ('sunday', 'monday', 2),
        ('SUNDAY', 'sunday', 0),
        ('female', 'male', 2)
    );

    for @tests -> ($S1, $S2, $expected) {
        is(challenge($S1, $S2), $expected);
    }

    done-testing;
}
