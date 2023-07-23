#!/usr/bin/env raku

use v6.d;

sub shuffle-string(Str:D $string, Int:D @indices --> Str:D) {
    my %shuffle-dict = @indices >>=><< $string.comb;
    return join '', %shuffle-dict{0..^$string.chars};
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is shuffle-string('lacelengh', Array[Int:D].new((3,2,0,5,4,8,6,7,1))),
        'challenge', 'works for "lacelengh"';
    is shuffle-string('rulepark', Array[Int:D].new((4,7,3,1,0,5,2,6))),
        'perlraku', 'works for "rulepark"';
}

