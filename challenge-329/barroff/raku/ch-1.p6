#!/usr/bin/env raku

use v6.d;

sub counter-integers(Str $str --> Seq) {
    $str.split(/<lower>+/, :skip-empty).unique;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is counter-integers("the1weekly2challenge2"), (1, 2), 'works for "the1weekly2challenge2"';
    is counter-integers("go21od1lu5c7k"), (21, 1, 5, 7), 'works for "go21od1lu5c7k"';
    is counter-integers("4p3e2r1l"), (4, 3, 2, 1), 'works for "4p3e2r1l"';
}

#| Take user provided string like "the1weekly2challenge2"
multi sub MAIN(Str $str) {
    say counter-integers($str);
}
