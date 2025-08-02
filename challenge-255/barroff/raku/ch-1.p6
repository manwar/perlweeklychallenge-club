#!/usr/bin/env raku

use v6.d;

sub odd-character(Str:D $s, Str:D $t --> Str:D) {
    (Bag($t.comb) (-) Bag($s.comb)).keys[0];
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is odd-character("Perl", "Preel"), "e", 'works for "Perl"';
    is odd-character("Weekly", "Weeakly"), "a", 'works for "Weekly"';
    is odd-character("Box", "Boxy"), "y", 'works for "Box"';
}

#| Take user provided word like aba
multi sub MAIN(Str:D $s, Str:D $t) {
    say odd-character($s, $t);
}
