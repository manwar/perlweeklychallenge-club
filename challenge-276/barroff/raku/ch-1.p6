#!/usr/bin/env raku

use v6.d;

sub complete-day(@hours --> Int) {
    grep({ sum($_) mod 24 == 0 }, @hours.combinations: 2).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is complete-day([12, 12, 30, 24, 24]), 2, 'works for [12, 12, 30, 24, 24]';
    is complete-day([72, 48, 24, 5]), 3, 'works for [72, 48, 24, 5]';
    is complete-day([12, 18, 24]), 0, 'works for [12, 18, 24]';
}

#| Take user provided number like 1024 512 256 128 64
multi sub MAIN(*@hours) {
    say complete-day(@hours);
}
