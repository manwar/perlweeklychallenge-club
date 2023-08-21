#!/usr/bin/env raku

use v6.d;

sub count-words(@words, Str $prefix --> Int) {
    (grep { /^ $prefix / }, @words).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is count-words(("pay", "attention", "practice", "attend"), 'at'), 2,
        'works for ("pay", "attention", "practice", "attend")';
    is count-words(("janet", "julia", "java", "javascript"), 'ja'), 3,
        'works for ("janet", "julia", "java", "javascript")';
}


#| Take user provided list like 1 24 51 60
multi sub MAIN(Str $prefix, *@words where @words.elems ≥ 1) {
    say count-words(@words, $prefix);
}
