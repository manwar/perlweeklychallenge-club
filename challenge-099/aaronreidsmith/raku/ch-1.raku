#!/usr/bin/env raku

sub challenge(Str $S, Str $P) returns Int {
    my $regex = '^' ~ $P.trans(['*', '?'] => ['.*', '.']) ~ '$';
    ($S ~~ /<$regex>/).Bool.Int;
}

multi sub MAIN(Str $S, Str $P) {
    say challenge($S, $P);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ('abcde', 'a*e'  , 1),
        ('abcde', 'a*d'  , 0),
        ('abcde', '?b*d' , 0),
        ('abcde', 'a*c?e', 1),
        ('acde' , 'a*c?e', 1)  # Treat '*' as '0 or more'
    );

    for @tests -> ($S, $P, $expected) {
        is(challenge($S, $P), $expected);
    }

    done-testing;
}
