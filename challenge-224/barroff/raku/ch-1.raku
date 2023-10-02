#!/usr/bin/env raku

use v6.d;

sub special-notes(Str:D $source, Str:D $target --> Bool) {
    $target.comb.Bag ⊆ $source.comb.Bag;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is special-notes('abc', 'xyz'), False, 'works for ("abc", "xyz")';
    is special-notes('scriptinglanguage', 'perl'), True, 'works for ("scriptinglanguage", "perl")';
    is special-notes('aabbcc', 'abc'), True, 'works for ("aabbcc", "abc")';
}

#| Take user provided list like 1 17 8
multi sub MAIN(Str:D $source, Str:D $target) {
    say special-notes($source, $target);
}

