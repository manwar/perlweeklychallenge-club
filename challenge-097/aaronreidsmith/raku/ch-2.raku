#!/usr/bin/env raku

use Text::Levenshtein; # imports `distance`

sub challenge(
    Str $B where $B ~~ /^[0|1]+$/,
    Int $S where $S > 0
) {
    my @segments = $B.comb.rotor($S, :partial).map(-> @chars {
        my $segment = @chars.join;
        $segment ~ '0' x ($S - $segment.chars) # Right-pad with zeros if necessary
    });
    distance(|@segments).sum;
}

multi sub MAIN(Str $B, Int $S) {
    say challenge($B, $S);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ('101100101', 3, 1),
        ('10110111', 4, 2),
        ('10111', 4, 2) # should handle partial segments
    );

    for @tests -> ($B, $S, $expected) {
        is(challenge($B, $S), $expected);
    }

    done-testing;
}
