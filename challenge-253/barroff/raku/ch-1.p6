#!/usr/bin/env raku

use v6.d;

sub split-strings(Str $separator, @words --> Seq) {
    map({ split($separator, $_, :skip-empty).Slip}, @words);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is split-strings(".", ("one.two.three","four.five","six")),
        ("one","two","three","four","five","six"),
        'works for ("one.two.three","four.five","six")';
    is split-strings('$', ('$perl$$', '$$raku$')), ("perl","raku"),
        'works for ("$perl$$", "$$raku$")';
}

#| Take user provided list like aba aabb abcd bac aabc
multi sub MAIN(*@s) {
    say split-strings(@s[0], @s[1..*]);
}
