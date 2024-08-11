#!/usr/bin/env raku

use v6.d;

sub check-color(Str $coordinates where $coordinates ~~ /^ <[a..h]> <[1..8]> / --> Bool) {
    my $translated = $coordinates.trans(['a'..'h'] => ['0'..'7']);
    (sum($translated.comb) mod 2) == 0
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is check-color("d3"), True, 'works for "d3"';
    is check-color("g5"), False, 'works for "g5"';
    is check-color("e6"), True, 'works for "e6"';
}

#| Take user provided string like "d3"
multi sub MAIN(Str $coordinates where $coordinates ~~ /^ <[a..h]> <[1..8]> /) {
    say check-color($coordinates);
}
