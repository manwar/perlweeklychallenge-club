#!/usr/bin/env raku

use v6.d;

sub upper-lower(Str:D $str where $str ~~ /^ <alpha>* $/ --> Str:D) {
    map({ $_ ~~ /<lower>/ ?? $_.uc !! $_.lc }, $str.comb).join
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is upper-lower("pERl"), "PerL", 'works for "pERl"';
    is upper-lower("raku"), "RAKU", 'works for "raku"';
    is upper-lower("PyThOn"), "pYtHoN", 'works for "PyThOn"';
}

#| Take user provided strs like "Perl Weekly Challenge" l a
multi sub MAIN(*@words) {
    say map(&upper-lower, @words).join(" ");
}
