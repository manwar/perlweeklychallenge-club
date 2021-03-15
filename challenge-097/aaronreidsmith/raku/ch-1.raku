#!/usr/bin/env raku

constant @alphabet = ('A'..'Z').List;

sub challenge(
    Str $S where $S ~~ /^[<alpha>|<space>]+$/,
    Int $N where $N >= 0
) {
    $S.uc.trans(@alphabet => @alphabet.rotate(-$N));
}

multi sub MAIN(Str $S, Int $N) {
    say challenge($S, $N);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG', 3, 'QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD'),
        ('raku is part of the perl family', 5, 'MVFP DN KVMO JA OCZ KZMG AVHDGT'), # Should make input uppercase
        ('THIS IS USELESS', 0, 'THIS IS USELESS') # $N = 0 leaves it the same
    );

    for @tests -> ($S, $N, $expected) {
        is(challenge($S, $N), $expected);
    }

    done-testing;
}
